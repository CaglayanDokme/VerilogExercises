//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 09.05.2020
// Module Name: 2to1 Multiplexer - Case 
// Description: 
// Revision:
// 09.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module mux2to1_case(input a0,
                    input a1,
                    input s,
                    output y );
                    
    reg r_y;
    
    always @ (s or a0 or a1) begin
        case(s)
            1'b0 : r_y = a0;
            1'b1 : r_y = a1;
        endcase
        
        // Alternative design
//        case(s)
//            1'b0    : r_y = a0;
//            default : r_y = a1;
//        endcase
    end
        
    assign y = r_y;
endmodule
