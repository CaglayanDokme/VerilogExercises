//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 09.05.2020
// Module Name: DFF with asynchronous reset
// Description: 
// Revision:
// 09.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module d_ff_async( 
    input       d,
    input       clk,
    input       clrn,   // Active-Low Clear
    output reg  q
);
    
always@(posedge clk or negedge clk) begin
    if(!clrn)   // If Clear is asserted, reser DFF
        q <= 0; 
    else      
        q <= d; // Else, store data
end
endmodule
