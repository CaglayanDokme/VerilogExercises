//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 03.07.2020
// Module Name: 32-Bit Single Cycle Instruction Memory 
// Description: Figure 5.20
// Revision:
// 03.07.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
module SingleCycleInstMem(input  [31:0] address,
                          output [31:0] instruction);
                          
    wire [31:0] rom[0:31];  // ROM Cells (32 words)
    
    //      ROM[ADDR] = INSTRUCTION     // PC   LABEL   INSTRUCTION
    assign rom[5'h00] = 32'h3C01_0000;  // 00   MAIN:   LUI $1, 0    
    assign rom[5'h01] = 32'h3424_0050;  // 04           ORI $4, $1, 80      # 80 = 0x50 => Word Address = 0x1E 
    assign rom[5'h02] = 32'h2005_0004;  // 08           ADDI $5, $0, 4      # Loop counter initializes here
    assign rom[5'h03] = 32'h0C00_0018;  // 0C   CALL:   JAL SUM             # Subroutine Call
    assign rom[5'h04] = 32'hAC82_0000;  // 10           SW $2, 0($4)        # Store sum total to memory. Right after the sum values
    assign rom[5'h05] = 32'h8C89_0000;  // 14           LW $9, 0($4)        # Load stored value back again            
    assign rom[5'h06] = 32'h0124_4022;  // 18           SUB $8, $9, $4            
    assign rom[5'h07] = 32'h2005_0003;  // 1C           ADDI $5, $0, 3      # $5 = 3
    assign rom[5'h08] = 32'h20A5_FFFF;  // 20   LOOP2:  ADDI $5, $5, -1     # $5--
    assign rom[5'h09] = 32'h34A8_FFFF;  // 24           ORI $8, $5, 0xFFFF  # $8 = 0xFFFF            
    assign rom[5'h0A] = 32'h3908_5555;  // 28           XORI $8, $8, 0x5555 # $8 = 0xAAAA           
    assign rom[5'h0B] = 32'h2009_FFFF;  // 2C           ADDO $9, $0, -1     # $9 = 0xFFFF_FFFF
    assign rom[5'h0C] = 32'h312A_FFFF;  // 30           ANDI $10, $9, 0xFFFF # $10 = 0xFFFF
    assign rom[5'h0D] = 32'h0149_3025;  // 34           OR $6, $10, $9      # $6 = 0xFFFF_FFFF
    assign rom[5'h0E] = 32'h0149_4026;  // 38           XOR $8, $10, $9     # #8 = 0xFFFF_0000
    assign rom[5'h0F] = 32'h0146_3824;  // 3C           AND $7, $10, $6     # $7 = 0xFFFF
    assign rom[5'h10] = 32'h10A0_0001;  // 40           BEQ $5, $0, SHIFT   
    assign rom[5'h11] = 32'h0800_0008;  // 44           J LOOP2             # while($5 > 0)
    assign rom[5'h12] = 32'h2005_FFFF;  // 48   SHIFT:  ADDI $5, $0, -1     # $5 = 0xFFFF_FFFF
    assign rom[5'h13] = 32'h0005_43C0;  // 4C           SLL $8, $5, 15      # $8 = 0xFFFF_8000            
    assign rom[5'h14] = 32'h0008_4400;  // 50           SLL $8, $8, 16      # $8 = 0x8000_0000            
    assign rom[5'h15] = 32'h0008_4403;  // 54           SRA $8, $8, 16      # $8 = 0xFFFF_8000            
    assign rom[5'h16] = 32'h0008_43C2;  // 58           SRL $8, $8, 15      # $8 = 0x0001_FFFF            
    assign rom[5'h17] = 32'h0800_0017;  // 5C   FINISH  J FINISH            # while(1);
    assign rom[5'h18] = 32'h0000_4020;  // 60   SUM:    ADD $8, $0, $0      # $8 includes sum total and initialized with 0
    assign rom[5'h19] = 32'h8C89_0000;  // 64   LOOP:   LW $9, 0($4)        # Load data from memory 
    assign rom[5'h1A] = 32'h2084_0004;  // 68           ADDI $4, $4, 4      # Advance memory read location
    assign rom[5'h1B] = 32'h0109_4020;  // 6C           ADD $8, $8, $9      # Add memory data to current sum total
    assign rom[5'h1C] = 32'h20A5_FFFF;  // 70           ADDI $5, $5, -1     # $5--
    assign rom[5'h1D] = 32'h14A0_FFFB;  // 74           BNE $5, $0, LOOP    # while($5 > 0)
    assign rom[5'h1E] = 32'h0008_1000;  // 78           SLL $2, $8, 0       # Something like MOV
    assign rom[5'h1F] = 32'h03E0_0008;  // 7C           JR $31              # Return
    
    assign instruction = rom[address[6:2]]; // Use word adress to read ROM
    
    
endmodule
