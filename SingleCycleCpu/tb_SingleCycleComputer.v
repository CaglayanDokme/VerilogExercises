`timescale 1ns / 1ps

module tb_SingleCycleComputer();

    reg clk;                    // Clock
    reg clrn;                   // Reset (Active-Low)
    wire [31:0] progCounter;    // Program Counter
    wire [31:0] instruction;    // Instruction
    wire [31:0] aluOut;         // ALU Output
    wire [31:0] memOut;
    
    SingleCycleComputer_Behavioral SC_COMPUTER(clk, 
                                    clrn, 
                                    progCounter,
                                    instruction,
                                    aluOut,    
                                    memOut);
    
    initial begin
        clk     <= 1'b0;
        clrn    <= 1'b0;
        #150;
        @(posedge(clk));
        clrn    <= 1'b1;
    end            
    
    always #5 clk = ~clk;
                        
endmodule
