//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 09.05.2020
// Module Name: 2to1 Multiplexer - Function
// Description: 
// Revision:
// 09.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module mux2to1_function(input a0,
                        input a1,
                        input s,
                        output y );
    
    // Function declaration               
    function sel;
        input a, b, c;
        
        case(c)
            1'b0 : sel = a;
            1'b1 : sel = b;
        endcase
    endfunction
    
    // Function declaration 
    function sel_if;    // Alternative
        input a, b, c;
        
        if(c) 
            sel_if = b;
        else 
            sel_if = a;
    endfunction
    
    // Function usage example
    assign y = sel(a0, a1, s);
    // assign y = sel_if(a0, a1, s);    // Alternative
endmodule
