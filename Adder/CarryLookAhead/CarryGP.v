//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 26.05.2020
// Module Name: Generator of carry generator, propagator and next carry out 
// Description: Figure 3.10 shows related schematic
// Revision:
// 26.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module CarryGP(
    input [1:0] g, p,   // Lower level 2-set G, P
    input c_in,         // Lower level Carry-In
    output g_out, p_out, c_out);    // Higher level G, P, Carry-Out
    
    assign g_out = g[1] | p[1] & g[0];  // higher level carry generator
    assign p_out = p[1] & p[0];         // higher level carry propagator
    assign c_out = g[0] | p[0] & c_in;  // higher level carry_out;
    
endmodule
