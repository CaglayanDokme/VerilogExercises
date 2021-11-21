//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 14.09.2020
// Module Name: 32-Bit Single Cycle CPU Core (Behavioral) 
// Description: Exercise 5.2
//              Use behavioral-style Verilog HDL to design a single-cycle CPU. 
//              Hint:   There is no need to have an ALU control signal.
//                      Use case statement to deal with each instruction.
// Revision:
// 14.09.2020 -> Revision 0.01 - Created
// 15.09.2020 -> Revision 0.02 - Bugs fixed - (Verified)
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module SingleCycleCPU_Behavioral( input clk,
                                  input clrn,
                                  input  [31:0] instruction,    // Instruction input
                                  input  [31:0] dataFromMem,    // Data fetched from data memory unit
                                  output [31:0] progCounter,    // Program counter
                                  output        writeToMem,     // Enable flag for write to memory 
                                  output [31:0] aluOut,         // Output of ALU
                                  output [31:0] dataToMem);
                                  
    // Instruction Fields (Decode)                      
    wire [05:0] opCode   = instruction[31:26];
    wire [04:0] rs       = instruction[25:21];
    wire [04:0] rt       = instruction[20:16];
    wire [04:0] rd       = instruction[15:11];
    wire [05:0] func     = instruction[05:00];
    wire [15:0] imm      = instruction[15:00];
    wire [25:0] addr     = instruction[25:00];         
    
    // Program Counter
    reg [31:00] pc;
    
    // Register File    // R0 - Constant Zero
    reg [31:0] regFile[0:31];
    
    // Stall Register
    reg stall;
    
    // Output registers
    reg         m_writeToMem;
    reg [31:00] m_aluOut;
    reg [31:00] m_dataToMem;
	
	// Initialize register file and program counter
	integer i;
    initial begin
		pc 				<= 32'h0000_0000;
		m_aluOut 		<= 32'h0000_0000;
		m_dataToMem 	<= 32'h0000_0000;
		m_writeToMem	<= 1'b0;
		stall           <= 1'b0;
	
        for(i = 0; i < 32; i = i + 1)
            regFile[i] <= 32'h0000_0000;
    end
    
    // Main core
    always@(posedge(clk)) begin
        // Reset
		if(!clrn) begin
			pc 				<= 32'h0000_0000;
			m_aluOut 		<= 32'h0000_0000;
			m_dataToMem 	<= 32'h0000_0000;
			m_writeToMem	<= 1'b0;
            stall           <= 1'b0;
			
			for(i = 0; i < 32; i = i + 1)
				regFile[i] <= 32'h0000_0000;
		end
		// LW instruction stalls the core for one cycle
		else if(stall == 1'b1) begin
			stall 	<= 1'b0;	// Deassert stall flag
			pc 		<= pc + 4;	// Increase PC and continue program flow
			
			// Complete LW
			if(opCode == 6'b10_0011) begin
				if(rt != 5'h00) begin	// If writable
				 	regFile[rt] <= dataFromMem; 	// Data
				end 					
			end
		end	
		else begin
			pc              <= pc + 4;   // Increase Program Counter
			m_writeToMem    <= 1'b0;  
			m_aluOut        <= 32'h0;
			m_dataToMem     <= 32'h0;
			  
			case(opCode)
				// ADD, SUB, AND, OR, XOR, SLL, SRL, SRA, JR    // RD = RS op RT
				6'b00_0000: begin
					case(func)
						// ADD
						6'b10_0000: begin
							if(rd != 5'h00) begin
								regFile[rd] <= regFile[rs] + regFile[rt];
							end
						end
					
						// SUB
						6'b10_0010: begin
							if(rd != 5'h00) begin
								regFile[rd] <= regFile[rs] - regFile[rt];
							end
						end
						
						// AND
						6'b10_0100: begin
							if(rd != 5'h00) begin
								regFile[rd] <= regFile[rs] & regFile[rt];
							end
						end
					
						// OR
						6'b10_0101: begin
							if(rd != 5'h00) begin
								regFile[rd] <= regFile[rs] | regFile[rt];
							end
						end
						
						// XOR
						6'b10_0110: begin
							if(rd != 5'h00) begin
								regFile[rd] <= regFile[rs] ^ regFile[rt];
							end
						end
					
						// SLL
						6'b00_0000: begin
							if(rd != 5'h00) begin
								regFile[rd] <= regFile[rs] << regFile[rt];
							end
						end
											
						// SRL
						6'b00_0010: begin
							if(rd != 5'h00) begin
								regFile[rd] <= regFile[rs] >> regFile[rt];
							end
						end
					
						// SRA
						6'b00_0011: begin
							if(rd != 5'h00) begin
								regFile[rd] <= regFile[rs] >>> regFile[rt];
							end
						end
										
						// JR
						6'b00_1000: begin
							pc <= regFile[rs];
						end
						
						default: begin
						end
					endcase	// Function case
				end
				
				// ADDI     // RT = RS + (sign)IMMEDIATE
				6'b00_1000: begin
					if(rt != 5'h00) begin
						regFile[rt] <= regFile[rs] + {{16{imm[15]}}, imm[15:0]};
					end 					
				end
				
				// ANDI     // RT = RS & (zero)IMMEDIATE
				6'b00_1100: begin
					if(rt != 5'h00) begin
						regFile[rt] <= regFile[rs] & {{16{1'b0}}, imm[15:0]};
					end 					
				end
				
				// ORI      // RT = RS | (zero)IMMEDIATE
				6'b00_1101: begin
					if(rt != 5'h00) begin
						regFile[rt] <= regFile[rs] | {{16{1'b0}}, imm[15:0]};
					end 					
				end
				
				// XORI     // RT = RS ^ (zero)IMMEDIATE
				6'b00_1110: begin
					if(rt != 5'h00) begin
						regFile[rt] <= regFile[rs] ^ {{16{1'b0}}, imm[15:0]};
					end 					
				end
				
				// LW       // RT = memory[RS + OFFSET]
				6'b10_0011: begin
					m_aluOut 	<= regFile[rs] + {{16{1'b0}}, imm[15:0]};   // Address
					stall 		<= 1'b1;	// Assert stall flag. Data will be fetched after one cycle
					pc 			<= pc;		// Do not increase PC
					
					// if(rt != 5'h00) begin
					//  	regFile[rt] <= dataFromMem; 	// Data
					// end 					
				end
				
				// SW       // memory[RS + OFFSET] = RT
				6'b10_1011: begin
					m_writeToMem    <= 1'b1;                                    // Write enable
					m_aluOut        <= regFile[rs] + {{16{1'b0}}, imm[15:0]};   // Address
					m_dataToMem     <= regFile[rt]; 
				end
				
				// BEQ      // If rs equals to rt, then PC = label
				6'b00_0100: begin
					if(regFile[rs] == regFile[rt]) begin
						pc <= pc + 4 + {{16{imm[15]}}, imm[13:0], 2'b00};
					end
				end
				
				// BNE      // If rs not equals to rt, then PC = label
				6'b00_0101: begin
					if(regFile[rs] != regFile[rt]) begin
						pc <= pc + 4 + {{16{imm[15]}}, imm[13:0], 2'b00};
					end
				end
				
				// LUI      // RT = IMMEDIATE << 16
				6'b00_1111: begin
					if(rt != 5'h00) begin
						regFile[rt] <= imm << 16;
					end 					
				end
				
				// J        // Direct jump
				6'b00_0010: begin
					pc <= {4'b0000, addr, 2'b00};
				end
				
				// JAL      // Subroutine call. Save return address(PC + 4) to R31
				6'b00_0011: begin
					regFile[31] <= pc + 4;
					pc 			<= {{14{1'b0}}, imm[15:0], {2{1'b0}}};	// PC = IMM << 2
				end
				
				default: begin
			
				end
			endcase	// Instruction case
			
			regFile[0] <= 32'h0; // Prevent writes to R0
		end	// Else
    end 
    
	// Output Logic
    assign aluOut 		= m_aluOut;
	assign dataToMem 	= m_dataToMem;
	assign writeToMem	= m_writeToMem;
    assign progCounter 	= pc;                        
endmodule
