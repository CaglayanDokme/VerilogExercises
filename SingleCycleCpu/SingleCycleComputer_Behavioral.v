`timescale 1ns / 1ps

module SingleCycleComputer_Behavioral(input clk,   // Clock
                           input clrn,  // Reset (Active-Low)
                           output [31:0] progCounter,   // Program Counter
                           output [31:0] instruction,   // Instruction
                           output [31:0] aluOut,        // ALU Output
                           output [31:0] memOut);       // Data Memory Output
                           
    wire [31:0] data;   // Data to data memory
	wire [31:0] dataFromMemory;
    wire        wmem;   // Write to data memory
    
    // CPU Core
    SingleCycleCPU_Behavioral scCore(clk, clrn, instruction, dataFromMemory, progCounter, wmem, aluOut, data);
    
    // Instruction Memory 
    SingleCycleInstMem instMem(progCounter, instruction);
    
    // Data Memory                                   
    SingleCycleDataMem dataMem(clk, wmem, data, aluOut, dataFromMemory);
	
	assign memOut = dataFromMemory;
endmodule
