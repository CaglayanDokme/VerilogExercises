//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 12.06.2020
// Module Name: CLA 32 with overflow flag 
// Description: Designed to be used in ALU. Exercise 4.3
// Revision:
// 12.06.2020 -> Revision 0.01 - Created (Verificated)
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module CLA_32_TOP_v2(
    input  [31:0] a, b,
    input  ci,
    output [31:0] s,
    output overflow);
    
    wire g_out, p_out; // internal wires
    wire g_open, p_open;
    
    // CLA32
    CLA_32 C1(a, b, ci, g_out, p_out, s); // use cla_32 module
    
    // Carry GP (g, p, c_in, g_out, p_out, c_out)
    CarryGP GP1({0, g_out}, {0, p_out}, ci, g_open, p_open, overflow);
endmodule