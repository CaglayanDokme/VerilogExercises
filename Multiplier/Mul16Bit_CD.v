//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 27.05.2020
// Module Name: Basit 16-Bit Multiplier
// Description: Calculates the result at 16 cycles.
// Revision:
// 27.05.2020 -> Revision 0.01 - Created    (Verificated)
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module Mul16Bit_CD(
    input clk,                  // Clock    
    input start,                // Start signal (Pulse)
    input [15:0] a,b,           // Multiplicand and Multiplier
    output [31:0] result,       // Product
    output reg resultValid);    // Result Valid signal (Not Pulse)
    
    reg[31:0] m_a;          // Multiplicand
    reg[15:0] m_b;          // Multiplier  
    reg[31:0] m_product;    // Product     
    reg state = 1'b0;       // 0: Waiting for data, 1: Calculating 
    reg[3:0] counter = 4'd0;
    
    always@(posedge(clk)) begin
        // If state is waiting data
        if(state == 1'b0) begin
            if(start == 1'b1) begin
                state       = 1'b1;         // Next state is calculating 
                m_a         = {16'd0, a};   // Multiplicand
                m_b         = b;            // Multiplier
                m_product   = 32'd0;        // Product
                
                resultValid = 1'b0;
                counter     = 4'd0; // Reset counter
            end
        end else begin
            // If the current multiplier digit is not zero, we can add to product
            if(m_b[0] == 1'b1) begin
                m_product   = m_product + m_a;      // Add to product            
            end
            
            m_b = m_b >> 1;             // Shift multiplier 1-bit right
            m_a = m_a << 1;             // Shift multiplicand 1-bit left
            
            // If it is not the last digit
            if(counter != 4'd15) begin
                counter = counter + 1;  // Increment counter
            end else begin
                resultValid = 1'b1;     // Result is valid
                state = 1'b0;           // Next state is idle/waiting for data
            end
        end
    end
    
    assign result = m_product; 
endmodule
