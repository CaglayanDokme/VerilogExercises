//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 09.05.2020
// Module Name: 2to1 Multiplexer - If Else
// Description: 
// Revision:
// 09.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module mux2to1_behavioral(  input a0,
                            input a1,
                            input s,
                            output y );
    reg r_y;
                
    always @ (s or a0 or a1) begin
        if(s) begin
            r_y = a1;
        end else begin
            r_y = a0;
        end
    end
    
    assign y = r_y;
endmodule
