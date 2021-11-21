//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 09.05.2020
// Module Name: 2to1 Multiplexer - DataFlow
// Description: 
// Revision:
// 09.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module mux2to1_dataflow(input a0,
                        input a1,
                        input s,
                        output y );
                        
    //assign y = (~s & a0) | (s & a1);  
    assign y = s ? a1 : a0;                        
endmodule
