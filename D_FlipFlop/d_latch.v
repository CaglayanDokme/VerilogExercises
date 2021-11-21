//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 09.05.2020
// Module Name: D Latch with RS Latch and NAND Gates
// Description: 
// Revision:
// 09.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module d_latch(
    input c,
    input d,
    output q,
    output qn
    );
    
wire r, s;

// NAND(Out, In, In)
nand nand1(s, d, c);
nand nand2(r, ~d, c);

// RS_LATCH(S, R, Q, QN)
rs_latch rs(s, r, q, qn);

endmodule
