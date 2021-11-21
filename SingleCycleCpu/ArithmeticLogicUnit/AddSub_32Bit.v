//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 11.06.2020
// Module Name: 32-Bit Adder & Subtracter using Carry Look Ahead Adder with Overlow detector
// Revision:
// 11.06.2020 -> Revision 0.01 - Created                (Verificated)
// 12.06.2020 -> Revision 0.02 - Overflow flag added.   (Verificated)
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module AddSub_32Bit(input [31:0] a, b,
                    input sub,
                    output [31:0] result,
                    output overflow);
                    
    // sub == 1 : a - b = a + (-b) = a + not(b) + 1 = a + (b xor sub) + sub
    // sub == 0 : a + b = a +   b  = a +     b    0 = a + (b xor sub) + sub
    wire[31:0] b_xor_sub = b ^ {32{sub}};   // B xor sub
    
    // CLA32 (a, b, ci, s)
    CLA_32_TOP_v2 cla32(a, b_xor_sub, sub, result, overflow);
endmodule
