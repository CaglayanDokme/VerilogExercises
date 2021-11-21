//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 26.05.2020
// Module Name: 2-Bit Carry Look Ahead Adder
// Description: By using two add modules and a gp generator, we can design a 2-bit CLA.
// Revision:
// 26.05.2020 -> Revision 0.01 - Created
// 27.05.2020 -> Revision 0.02 - Bug fix.
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module CLA_2(
    input [1:0] a, b,
    input c_in,
    output g_out, p_out,
    output [1:0] s);
    
    wire[1:0] g, p;
    wire c_out;
    
    // 1-Bit CLA Adder (a, b, c, g, p, s)                   // Generates G, P, S 
    Adder1Bit_CLA A1(a[0], b[0], c_in, g[0], p[0], s[0]);   // Add on bit 0
    Adder1Bit_CLA A2(a[1], b[1], c_out, g[1], p[1], s[1]);   // Add on bit 1
    
    // Carry GP (g, p, c_in, g_out, p_out, c_out)
    CarryGP GP1(g, p, c_in, g_out, p_out, c_out);           // Higher level G, P
    
endmodule
