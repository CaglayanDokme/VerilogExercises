//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 26.05.2020
// Module Name: 32-Bit Carry Look Ahead Adder
// Description: By using two 16-bit CLA modules and a gp generator, we can design a 32-bit CLA.
// Revision:
// 26.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module CLA_32(
    input [31:0] a, b,
    input c_in,
    output g_out, p_out,
    output [31:0] s);
    
    wire[1:0] g, p;
    wire c_out;
    
    // CLA16 
    CLA_16 C1(a[15:0], b[15:0], c_in, g[0], p[0], s[15:0]);         // Add on bit 0
    CLA_16 C2(a[31:16], b[31:16], c_out, g[1], p[1], s[31:16]);     // Add on bit 1
    
    // Carry GP (g, p, c_in, g_out, p_out, c_out)
    CarryGP GP1(g, p, c_in, g_out, p_out, c_out);               // Higher level G, P
endmodule