//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 09.05.2020
// Module Name: 2to1 Multiplexer - CMOS
// Description: 
// Revision:
// 09.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module mux2to1_cmos(input s,
                    input a0,
                    input a1,
                    output y );
                    
    wire w_snot;
    
    // CMOSNOT(f, a)
    cmosnot inv(w_snot, s);
    
    // CMOSCMOS(n_gate, p_gate, source, drain)
    cmos_passgate c0(s, w_snot, a0, y);
    cmos_passgate c1(w_snot, s, a1, y);
    
endmodule
