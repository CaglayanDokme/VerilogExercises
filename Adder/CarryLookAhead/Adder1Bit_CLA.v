//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 26.05.2020
// Module Name: 1-Bit Adder using Carry Look Ahead 
// Description: Figure 3.10 shows related schematic
// Revision:
// 26.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module Adder1Bit_CLA(
    input a,
    input b,
    input c,
    output g,
    output p,
    output s);
    
    assign s = a ^ b ^ c;   // Sum of inputs
    assign g = a & b;       // Carry generator
    assign p = a | b;       // Carry propagator
    
endmodule
