//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 01.07.2020
// Module Name: 32-Bit Register File with 32 registers 
// Description: Figure 5.14
// Revision:
// 01.07.2020 -> Revision 0.01 - Created    (Verificated)
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module regfile32(input clk,     // Clock
                 input clrn,    // Reset (Active-Low)
                 
                 // Read
                 input  [4:0]  readOffset1,     // Read offset
                 input  [4:0]  readOffset2,     // Another read offset
                 output [31:0] readData1,       // Read data
                 output [31:0] readData2,       // Another read data
                 
                 // Write
                 input [31:0] writeData,            // Data to be written
                 input [4:0]  writeOffset,          // Write offset
                 input        writeEnable);         // Write enable flag
                 
    // Registers. (0th register is constant zero)                 
    reg[31:0] register[1:31];
    
    integer i;
    initial begin
        for(i = 1; i < 32; i = i + 1)
            register[i] <= 32'h0000_0000;
    end
    
    always@(posedge(clk) or negedge(clrn)) begin
        if(!clrn) begin // Reset stored registers
            for(i = 1; i < 32; i = i + 1)
                register[i] <= 32'h0000_0000;
        end else begin
            // Write to given register address
            if((writeOffset != 0) && writeEnable) begin
                register[writeOffset] <= writeData;
            end
        end
    end
    
    // Read the pointed data registers
    assign readData1 = (readOffset1 == 0) ? 32'h0000_0000 : register[readOffset1];
    assign readData2 = (readOffset2 == 0) ? 32'h0000_0000 : register[readOffset2];                 
endmodule
