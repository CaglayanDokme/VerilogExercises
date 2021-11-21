//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 09.05.2020
// Module Name: 2to1 Multiplexer - Tristate Buffer
// Description: 
// Revision:
// 09.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module mux2to1_tristate(input a0,
                        input a1,
                        input s,
                        output y );
                        
    // BUFIF0(out, in, ct1) // BUFIF0 enables pass with Logic-0
    bufif0 b0(y, a0, s);
    
    // BUFIF1(out, in, ct1) // BUFIF1 enables pass with Logic-1
    bufif1 b1(y, a1, s);
                            
endmodule
