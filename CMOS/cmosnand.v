//////////////////////////////////////////////////////////////////////////////////
// Engineer     : Caglayan DOKME
// Create Date  : 09.05.2020
// Module Name  : CMOS NAND Gate
// Date         : 09.05.2020    -> Created.
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module cmosnand(
    input   a,
    input   b,
    output  f,
    supply1 vdd,
    supply0 gnd);
    
wire w_nmos;

// PMOS(drain, source, gate)
pmos p1(f, vdd, a);
pmos p2(f, vdd, b);

// NMOS(drain, source, gate)
nmos n1(f,      w_nmos, a);
nmos n2(w_nmos, gnd,    b);
    
endmodule
