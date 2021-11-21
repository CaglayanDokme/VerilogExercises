//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 28.05.2020
// Module Name: Restoring Square Root Algorithm Module
// Description: Calculates sqrt(d) = q^2 + r
//              Section 3.5.1 - Figure 3.28
// Revision:
// 28.05.2020 -> Revision 0.01 - Created (Validated)
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module SquareRoot_Restoring(
    input clk, clrn,
    input start,
    input [31:0] d,
    output[15:0] q,
    output[16:0] r,
    output reg busy, ready);
    
    reg[03:0] count;    // Stage counter
    reg[31:0] reg_d;    // Data to be rooted, 2 digits will be used every iteration
    reg[15:0] reg_q;    // Quotient
    reg[16:0] reg_r;    // Remainder
    
    // Remainder is left-shifted two bits with data register
    // Quotient is left-shifted one  bit and incremented with one.
    // Subtraction result includes difference of this two result.
    // Its sign is used to determine if the subtraction will be used or not.
    wire[17:0] sub_out = {reg_r[15:0], reg_d[31:30]} - {reg_q, 2'b1};                   
    
    // If subtraction sign is negative, then the remainder includes only the data-shifted version of itself. (sub[17] == 1)
    // If subtraction sign is positive, remainder includes the data-shifted subtraction result               (sub[17] == 0)
    wire[16:0] mux_out = sub_out[17] ? {reg_r[14:0], reg_d[31:30]} : sub_out[16:0];     // Restore or not
    
    always@(posedge(clk) or negedge(clrn)) begin
        if(!clrn) begin
            busy    <= 0;
            ready   <= 0;
        end else begin
            if(start) begin
                // Initialize registers
                reg_d <= d; 
                reg_q <= 0;
                reg_r <= 0;
                
                // Adjust status indicators
                busy  <= 1;
                ready <= 0;
                
                // Start counter
                count <= 0;
            end else if(busy) begin
                reg_d <= {reg_d[29:0], 2'b0};           // Left shift data register
                reg_q <= {reg_q[14:0], ~sub_out[17]};   // Append to quotient (Inverse of subtraction sign)
                reg_r <= mux_out;                       
                
                // Increase counter
                count <= count + 4'b1;
                
                // Check for the last stage
                if(count == 4'hF) begin
                    busy    <= 0;
                    ready   <= 1;
                end
            end
        end
    end
    
    // Output logic
    assign q = reg_q;
    assign r = reg_r;
endmodule
