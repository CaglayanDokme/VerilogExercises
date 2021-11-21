//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 09.05.2020
// Module Name: CMOS NOT Gate
// Description: 
// Revision:
// 09.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module cmosnot(f, a);
    input a;
    output f;
    supply1 vdd;
    supply0 gnd;
    
    // pmos(drain, source, gate);
    pmos p1(f, vdd, a);
    
    // nmos(drain, source, gate);
    nmos n1(f, gnd, a);
    
endmodule
