//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 26.05.2020
// Module Name: Full Adder (Behavioral)
// Description: 
// Revision:
// 26.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module fullAdder_Behavioral(
    input   a, b, ci,       // A, B and Carry Input
    output  s, co);          // S and Carry Out
    
    assign {co, s} = a + b + ci;
    
endmodule
