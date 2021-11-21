//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 09.05.2020
// Module Name: CMOS NOR Gate
// Description: 
// Revision:
// 09.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module cmosnor(
    input a,
    input b,
    output f,
    supply1 vdd,
    supply0 gnd
    );
    
    wire w_pmos;
    
    //PMOS(drain, source, gate)
    pmos p1(w_pmos, vdd,    a);
    pmos p2(f,      w_pmos, b);
    
    //NMOS(drain, source, gate)
    nmos n1(f, gnd, a);
    nmos n2(f, gnd, b);
endmodule
