//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 27.05.2020
// Module Name: 8-Bit Multiplier v2
// Description: AND and NAND operations to generate the partial product terms in the first part.
// Revision:
// 27.05.2020 -> Revision 0.01 - Created    (Verificated)
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module Mul8BitSigned_v2(
    input [7:0] a, b,
    output [15:0] result);
    
    reg [7:0] abi[7:0]; // a[i] & b[j]
    integer i, j;
    
    always @* begin
        for (i = 0; i < 7; i = i + 1)
            for (j = 0; j < 7; j = j + 1)
                abi[i][j] = a[i] & b[j]; // a[i] & b[j]
                
        for (i = 0; i < 7; i = i + 1)
            abi[i][7] = ~(a[i] & b[7]); // ?(a[i] & b[7])
            
        for (j = 0; j < 7; j = j + 1)
            abi[7][j] = ~(a[7] & b[j]); // ?(a[7] & b[j])
            
        abi[7][7] = a[7] & b[7];
    end
        
    assign result = (({8'b1,  abi[0][7:0]}          +   // << 0, + 1 in bit 8
                      {7'b0,  abi[1][7:0],  1'b0})  +   // << 1
                     ({6'b0,  abi[2][7:0],  2'b0}   +   // << 2
                      {5'b0,  abi[3][7:0],  3'b0})) +   // << 3
                    (({4'b0,  abi[4][7:0],  4'b0}   +   // << 4
                      {3'b0,  abi[5][7:0],  5'b0})  +   // << 5
                     ({2'b0,  abi[6][7:0],  6'b0}   +   // << 6
                      {1'b1,  abi[7][7:0],  7'b0}));     // << 7, + 1 in bit 15

endmodule
