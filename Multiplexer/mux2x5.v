//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 02.07.2020
// Module Name: Multiplexer 2-to-1 (5-Bit)
// Revision:
// 02.07.2020 -> Revision 0.01 - Created  
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module mux2x5(input [4:0] a0, a1,
              input selection,
              output reg [4:0] y);
               
    always@(a0, a1, selection) begin
        case(selection)
            1'b0: 
                y = a0;
            1'b1:
                y = a1;
        endcase
    end
endmodule
