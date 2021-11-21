//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 02.07.2020
// Module Name: 32-Bit D-FlipFlop
// Revision:
// 02.07.2020 -> Revision 0.01 - Created    (Verificated)
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module dff32(input clk,                 // Clock
             input clrn,                // Reset (Active-Low)
             input [31:0] nextValue,    // Value to be stored
             output [31:0] oldValue);   // Previous stored value
             
    reg [31:0] storedValue = 32'h0000_0000;
    
    always@(posedge(clk) or negedge(clrn)) begin
        if(!clrn) begin
            storedValue <= 32'h0000_0000;
        end else begin  
            storedValue <= nextValue;
        end
    end                 
    
    assign oldValue = storedValue;
endmodule
