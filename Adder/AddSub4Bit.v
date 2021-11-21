//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 26.05.2020
// Module Name: 4-Bit Adder/Subtractor
// Description: Figure 3.8 shows related schematic
// Revision:
// 26.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module AddSub4Bit(
    input [3:0] a,  // 4-Bit Inputs
    input [3:0] b,
    input ci,       // Carry in
    input sub,      // 1: Sub(s = a - b - ci), 0: Add(s = a + b + ci)
    output [3:0] s, // Result
    output co);     // Carry out
    
    // Logic of operation
    // sub==1, ci==0: a-b-ci = a+(-b)-0 = a+(?b+1)-0 = a+(b ? sub)+(ci ? sub)
    // sub==1, ci==1: a-b-ci = a+(-b)-1 = a+(?b+1)-1 = a+(b ? sub)+(ci ? sub)
    // sub==0, ci==0: a+b+ci = a+ b +0 = a+ b +0 = a+(b ? sub)+(ci ? sub)
    // sub==0, ci==1: a+b+ci = a+ b +1 = a+ b +1 = a+(b ? sub)+(ci ? sub)
    
    wire[3:0] bx    = b ^ {4{sub}};    // b xor sub
    wire      cix   = ci ^ sub;        // ci xor sub
    wire[2:0] c;                       // Internal carriers
    
    // FullAdder(a, b, ci, s, co)
    fullAdder_Structural fa1(a[0], bx[0], cix, s[0], c[0]);
    fullAdder_Structural fa2(a[1], bx[1], c[0], s[1], c[1]);
    fullAdder_Structural fa3(a[2], bx[2], c[1], s[2], c[2]);
    fullAdder_Structural fa4(a[3], bx[3], c[2], s[3], co);  
endmodule
