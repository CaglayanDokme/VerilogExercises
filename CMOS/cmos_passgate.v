//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 09.05.2020
// Module Name: Passgate CMOS
// Description: 
// Revision:
// 09.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module cmos_passgate(   input p_gate,
                        input n_gate,
                        input source,
                        output drain    );
                        
    // PMOS(drain, source, gate)
    pmos p1(drain, source, p_gate);
    
    // NMOS(drain, source, gate)                        
    nmos n1(drain, source, n_gate);
                           
endmodule
