//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 09.05.2020
// Module Name: 3-Bit Demultiplexer
// Description: 
// Revision:
// 09.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module demux_3bit(  input [2:0]     sel,
                    input           a,
                    output [7:0]    f );
                    
    assign f = (1 << sel) & {8{a}};
    
endmodule
