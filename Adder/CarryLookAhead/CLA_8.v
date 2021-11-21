//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 26.05.2020
// Module Name: 8-Bit Carry Look Ahead Adder
// Description: By using two 4-bit CLA modules and a gp generator, we can design a 8-bit CLA.
// Revision:
// 26.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module CLA_8(
    input [7:0] a, b,
    input c_in,
    output g_out, p_out,
    output [7:0] s);
    
    wire[1:0] g, p;
    wire c_out;
    
    // CLA4 
    CLA_4 C1(a[3:0], b[3:0], c_in, g[0], p[0], s[3:0]);     // Add on bit 0
    CLA_4 C2(a[7:4], b[7:4], c_out, g[1], p[1], s[7:4]);    // Add on bit 1
    
    // Carry GP (g, p, c_in, g_out, p_out, c_out)
    CarryGP GP1(g, p, c_in, g_out, p_out, c_out);           // Higher level G, P
endmodule