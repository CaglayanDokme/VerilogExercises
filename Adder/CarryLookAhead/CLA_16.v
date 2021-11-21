//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 26.05.2020
// Module Name: 16-Bit Carry Look Ahead Adder
// Description: By using two 8-bit CLA modules and a gp generator, we can design a 16-bit CLA.
// Revision:
// 26.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module CLA_16(
    input [15:0] a, b,
    input c_in,
    output g_out, p_out,
    output [15:0] s);
    
    wire[1:0] g, p;
    wire c_out;
    
    // CLA8 
    CLA_8 C1(a[7:0], b[7:0], c_in, g[0], p[0], s[7:0]);         // Add on bit 0
    CLA_8 C2(a[15:8], b[15:8], c_out, g[1], p[1], s[15:8]);     // Add on bit 1
    
    // Carry GP (g, p, c_in, g_out, p_out, c_out)
    CarryGP GP1(g, p, c_in, g_out, p_out, c_out);               // Higher level G, P
endmodule