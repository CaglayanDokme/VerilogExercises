//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 03.07.2020
// Module Name: 32-Bit Single Cycle Data Memory 
// Description: Figure 5.20
// Revision:
// 03.07.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module SingleCycleDataMem(input clk,                // Clock
                          input writeEnable,        // Write Enable 
                          input  [31:0] dataIn,     // Data Input Port
                          input  [31:0] address,    // Destination or Source Address
                          output [31:0] dataOut);   // Data Output Port
                          
    reg [31:0] ram[0:31];   // RAM Cells (32 words)
    
    integer i;
    initial begin
        for(i = 0; i < 32; i = i + 1)
            ram[i] <= 32'h0000_0000;
            
        ram[5'h14] <= 32'h0000_00A3; 
        ram[5'h15] <= 32'h0000_0027;
        ram[5'h16] <= 32'h0000_0079;
        ram[5'h17] <= 32'h0000_0115;
    end
    
    always@(posedge(clk)) begin
        // If write requested
        if(writeEnable) begin
            ram[address[6:2]] <= dataIn; // Use address to write to memory
        end
    end
    
    assign dataOut = ram[address[6:2]];    // Use word address to read RAM                          
endmodule
