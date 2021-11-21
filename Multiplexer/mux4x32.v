//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 02.07.2020
// Module Name: Multiplexer 4-to-1 (32-Bit)
// Revision:
// 02.07.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module mux4x32(input [31:0] a0, a1, a2, a3,
			   input [1:0] selection,
			   output reg [31:0] y);
                
    always@(selection or a0 or a1 or a2 or a3) begin
        case(selection)
            2'b00: y = a0;
            2'b01: y = a1;
            2'b10: y = a2;
            2'b11: y = a3;
        endcase
    end
    
endmodule
