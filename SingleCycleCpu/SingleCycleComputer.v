//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 02.07.2020
// Module Name: 32-Bit Single Cycle Computer 
// Description: Figure 5.20
// Revision:
// 02.07.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module SingleCycleComputer(input clk,   // Clock
                           input clrn,  // Reset (Active-Low)
                           output [31:0] progCounter,   // Program Counter
                           output [31:0] instruction,   // Instruction
                           output [31:0] aluOut,        // ALU Output
                           output [31:0] memOut);       // Data Memory Output
                           
    wire [31:0] data;   // Data to data memory
    wire        wmem;   // Write to data memory
    
    // CPU Core
    SingleCycleCPU scCore(clk, clrn, instruction, memOut, progCounter, wmem, aluOut, data);
    
    // Instruction Memory 
    SingleCycleInstMem instMem(progCounter, instruction);
    
    // Data Memory                                   
    SingleCycleDataMem dataMem(clk, wmem, data, aluOut, memOut);
                       
endmodule
