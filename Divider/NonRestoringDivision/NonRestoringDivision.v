//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 28.05.2020
// Module Name: Non-Restoring Division Algorithm Module
// Description: Calculates A/B = B.Q + R
// Revision:
// 28.05.2020 -> Revision 0.01 - Created (Validated)
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module NonRestoringDivision(
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
    
    wire[16:0] sub_add = reg_r[15] ? ({reg_r, reg_q[31]} + {1'b0, reg_b}) : ({reg_r, reg_q[31]} - {1'b0, reg_b});
        
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
                reg_q <= {reg_q[30:0], ~sub_add[16]};
                reg_r <= sub_add[15:0];
                count <= count + 5'b1;
                
                if(count == 5'h1f) begin
                    busy    <= 0;   // Calculation finished
                    ready   <= 1;   // Result ready
                end
            end
        end
    end
    
    assign q = reg_q;
    assign r = reg_r[15] ? (reg_r + reg_b) : reg_r;
endmodule
