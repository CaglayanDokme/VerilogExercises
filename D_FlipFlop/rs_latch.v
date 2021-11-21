//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 09.05.2020
// Module Name: 
// Description: RS Latch - with NAND gates
// Revision:
// 09.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module rs_latch(
    input s,
    input r,
    output q,
    output qn
    );
    
// NAND(Out, In, In); 
nand nand1(q, s, qn);
nand nand2(qn, q, r);   
endmodule
