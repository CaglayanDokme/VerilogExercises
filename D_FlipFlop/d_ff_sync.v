//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 09.05.2020
// Module Name: DFF with sycnhronous reset
// Description: 
// Revision:
// 09.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module d_ff_sync(   
    input       d,
    input       clk,
    input       clrn,   // Clear Active-Low
    output reg  q
);
    
always@(posedge clk) begin
    if(!clrn)   // If clear is asserted, reset 
        q <= 0;
    else        // Else, store d to dff
        q <= d;
end

endmodule
