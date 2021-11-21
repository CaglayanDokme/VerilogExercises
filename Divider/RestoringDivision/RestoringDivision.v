//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 28.05.2020
// Module Name: Restoring Division Algorithm Module
// Description: Calculates A/B = B.Q + R
//              Try to think the basic decimal Division algorithm. Use paper to
//              simulate the division step by step.
//
//           A  | B
//              |---
//        - B.Q | Q
//        ------|
//           R
//
// Revision:
// 28.05.2020 -> Revision 0.01 - Created (Validated)
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module RestoringDivision(
    input clk, clrn,    // Clock and Reset
    input [31:0] a,     // Dividend
    input [15:0] b,     // Divisor
    input start,        // Start signal
    output [31:0] q,    // Quotient
    output [15:0] r,    // Remainder
    output reg busy,    // Calculation continues    
    output reg ready);  // Ready 
    
    reg[31:0] reg_q;        // Quotient
    reg[15:0] reg_r, reg_b; // Remainder and divisor
    reg[4:0] count;         // Counter for algorithm
    
    wire[16:0] sub_out = {reg_r, reg_q[31]} - {1'b0, reg_b};
    wire[15:0] mux_out = sub_out[16] ? {reg_r[14:0], reg_q[31]} : sub_out[15:0];
        
    always@(posedge(clk) or negedge(clrn)) begin
        if(!clrn) begin
            busy    <= 0;   // No active calculation
            ready   <= 0;   // No result in output port      
        end else begin
            if(start) begin
                reg_q <= a; // Load Dividend
                reg_b <= b; // Load Divisor
                reg_r <= 0; // Remainder is initially 0
                busy  <= 1; // Calculation started
                ready <= 0; // Module is not ready anymore
                count <= 0; // Counter reset
            end else if(busy) begin
                reg_q <= {reg_q[30:0], ~sub_out[16]};
                reg_r <= mux_out;
                count <= count + 5'b1;
                
                if(count == 5'h1f) begin
                    busy    <= 0;   // Calculation finished
                    ready   <= 1;   // Result ready
                end
            end
        end
    end
    
    assign q = reg_q;
    assign r = reg_r;
endmodule
