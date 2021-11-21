//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 09.05.2020
// Module Name: 3-Bit Decoder
// Description: 
// Revision:
// 09.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module decoder_3bit(input [2:0] sel,
                    input a,
                    output [7:0] f );
                    
    reg[7:0] r_f;
    
    always @ (a or sel) begin
        r_f         = 8'b0;
        r_f[sel]    = a;
    end             
           
endmodule
