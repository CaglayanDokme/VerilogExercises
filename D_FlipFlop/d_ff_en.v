//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 09.05.2020
// Module Name: DFF with write Enable (asynchronous)
// Description: 
// Revision:
// 09.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module d_ff_en(     
    input       d,
    input       clk,
    input       clrn,   // Active-Low Clear
    input       e,
    output reg  q
);
    
always@(posedge clk or negedge clk) begin
    if(!clrn)   // If Clear is asserted, reser DFF
        q <= 0; 
    else if(e)  // If clear is not asserted and module is enabled, store the data   
        q <= d;
end
endmodule
