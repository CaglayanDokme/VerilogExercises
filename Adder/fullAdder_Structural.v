//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 26.05.2020
// Module Name: Full Adder (Structural)
// Description: 
// Revision:
// 26.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module fullAdder_Structural(
    input   a, b, ci,       // A, B and Carry Input
    output  s, co);          // S and Carry Out
    
    wire ab, bc, ca;
    
    xor x1(s, a, b, ci);
    and a1(ab, a, b);
    and a2(bc, b, ci);
    and a3(ca, ci, a);
    or o1(co, ab, bc, ca);
    
endmodule
