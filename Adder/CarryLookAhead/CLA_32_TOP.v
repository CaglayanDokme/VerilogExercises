//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 26.05.2020
// Module Name: Top module of 32-Bit Carry Look Ahead Adder 
// Description: To be used as a real 32-Bit adder, the G and P outputs must be removed from CLA_32 module.
// Revision:
// 26.05.2020 -> Revision 0.01 - Created    (Verificated)
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module CLA_32_TOP(
    input [31:0] a, b,
    input ci,
    output [31:0] s);
    
    wire g_out, p_out; // internal wires
    
    // CLA32
    CLA_32 C1(a, b, ci, g_out, p_out, s); // use cla_32 module
endmodule
