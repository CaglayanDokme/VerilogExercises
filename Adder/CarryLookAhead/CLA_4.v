//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 26.05.2020
// Module Name: 4-Bit Carry Look Ahead Adder
// Description: By using two 2-bit CLA modules and a gp generator, we can design a 4-bit CLA.
// Revision:
// 26.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module CLA_4(
    input [3:0] a, b,
    input c_in,
    output g_out, p_out,
    output [3:0] s);
    
    wire[1:0] g, p;
    wire c_out;
    
    // CLA2 
    CLA_2 C1(a[1:0], b[1:0], c_in, g[0], p[0], s[1:0]);     // Add on bit 0
    CLA_2 C2(a[3:2], b[3:2], c_out, g[1], p[1], s[3:2]);    // Add on bit 1
    
    // Carry GP (g, p, c_in, g_out, p_out, c_out)
    CarryGP GP1(g, p, c_in, g_out, p_out, c_out);           // Higher level G, P
endmodule
