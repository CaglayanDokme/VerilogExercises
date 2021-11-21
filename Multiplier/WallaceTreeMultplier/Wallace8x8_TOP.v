//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 28.05.2020
// Module Name: Main module of 8-Bit Wallace Tree Multplier
// Description: Figure 3.15, 3.16, 3.17
//              This top module utilizes the sub-module and completes the operation.
// Revision:
// 28.05.2020 -> Revision 0.01 - Created    (Verificated)
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module Wallace8x8_TOP(
    input [7:0] a, b,
    output [15:0] z
    );
    
wire[15:05] x, y, z_high;
wire[04:00] z_low;

Wallace8x8 wallaceTree(a, b, x, y, z_low);

assign z_high   = x + y;
assign z        = {z_high, z_low};

endmodule
