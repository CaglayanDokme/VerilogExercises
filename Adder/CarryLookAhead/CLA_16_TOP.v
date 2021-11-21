//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 08.06.2020
// Module Name: Top module of 16-Bit Carry Look Ahead Adder 
// Description: To be used as a real 16-Bit adder, the G and P outputs must be removed from CLA_16 module.
// Revision:
// 26.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module CLA_16_TOP(
    input [15:0] a, b,
    input ci,
    output [15:0] s);
    
    wire g_out, p_out;  // Will be open circuit
    
    // CLA 16
    CLA_16 cla(a, b, ci, g_out, p_out, s);
endmodule
