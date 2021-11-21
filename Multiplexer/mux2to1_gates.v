//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 09.05.2020
// Module Name: 2to1 Multiplexer - with Gates
// Description: 
// Revision:
// 09.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module mux2to1_gates(   input a0,
                        input a1,
                        input s,
                        output y);
                        
    wire w_snot, w_a0_snot, w_a1_s;
    
    // NOT(f, a)
    not g0(w_snot, s);
    
    // AND(f, a, b)
    and g1(w_a0_snot,   w_snot, a0);
    and g2(w_a1_s,      s,      a1);
    
    // OR(f, a, b)
    or g3(y, w_a0_snot, w_a1_s);   
                            
endmodule
