`timescale 1ns / 1ps

module SC_Computer_BMG(input clk,   // Clock
                       input clrn,  // Reset (Active-Low)
                       output [31:0] progCounter,   // Program Counter
                       output [31:0] instruction,   // Instruction
                       output [31:0] aluOut,        // ALU Output
                       output [31:0] memOut);       // Data Memory Output
                           
    wire [31:0] data;   // Data to data memory
    wire        wmem;   // Write to data memory
    wire wEnInst = 1'b0;
    
    // CPU Core
    SingleCycleCPU scCore(clk, clrn, instruction, memOut, progCounter, wmem, aluOut, data);
    
    // Instruction Memory 
    blk_mem_gen_0 InstBlockMem (
      .clka(clk),           // input wire clka
      .wea(1'b0),           // input wire [0 : 0] wea
      .addra(progCounter[9:2]),  // input wire [7 : 0] addra
      .dina(32'hDEAD_BEEF), // input wire [31 : 0] dina
      .douta(instruction)   // output wire [31 : 0] douta
    );
    
    // Data Memory                                   
    SingleCycleDataMem dataMem(clk, wmem, data, aluOut, memOut);
endmodule
