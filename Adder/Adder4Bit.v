//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 26.05.2020
// Module Name: 4-Bit Adder
// Description: 
// Revision:
// 26.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module Adder4Bit(
    input [3:0] a,  // Four bit inputs
    input [3:0] b,  
    input ci,       // Carry in
    output [3:0] s, // Sum
    output co);     // Carry out
    
    // Carry wires between full-adders
    wire[2:0] c;
    
    // FullAdder(a, b, ci, s, co)
    fullAdder_DataFlow fa1(a[0], b[0], ci, s[0], c[0]);
    fullAdder_DataFlow fa2(a[1], b[1], c[0], s[1], c[1]);
    fullAdder_DataFlow fa3(a[2], b[2], c[1], s[2], c[2]);
    fullAdder_DataFlow fa4(a[3], b[3], c[2], s[3], co);
    
endmodule
