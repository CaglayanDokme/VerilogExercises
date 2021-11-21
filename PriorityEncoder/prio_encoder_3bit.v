//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 09.05.2020
// Module Name: Priority Encoder
// Description: 
// Revision:
// 09.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module prio_encoder_3bit(input [7:0] d,
                         input ena,
                         output [2:0] n,
                         output g );

    // Function Declaration                         
    function[2:0] enc;
        input e;
        input[7:0] d;
        
        casex({e,d})    // x: don't care
            9'b1_1xxx_xxxx : enc = 3'd7; // Highest priority
            9'b1_01xx_xxxx : enc = 3'd6;
            9'b1_001x_xxxx : enc = 3'd5;
            9'b1_0001_xxxx : enc = 3'd4;
            9'b1_0000_1xxx : enc = 3'd3;
            9'b1_0000_01xx : enc = 3'd2;
            9'b1_0000_001x : enc = 3'd1;
            9'b1_0000_0001 : enc = 3'd0;
            default        : enc = 3'd0;
        endcase
    endfunction
                         
    assign g = ena & (|d);  // If there is atleast a 1 in d // Can be used for interrupt controllers
    assign n = enc(ena, d);                         
endmodule
