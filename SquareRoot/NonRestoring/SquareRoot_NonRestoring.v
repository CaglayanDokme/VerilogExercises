//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 08.06.2020
// Module Name: Non-Restoring Square Root Algorithm Module
// Description: Calculates sqrt(d) = q^2 + r
//              Section 3.5.2 - Figure 3.30
// Revision:
// 08.06.2020 -> Revision 0.01 - Created (Validated)
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module SquareRoot_NonRestoring(
    input clk, clrn,
    input start,
    input [31:0] d,
    output[15:0] q,
    output[16:0] r,
    output reg busy, ready);
    
    reg[03:0] count;    // Stage counter
    reg[31:0] reg_d;    // Data to be rooted, 2 digits will be used every iteration
    reg[15:0] reg_q;    // Quotient
    reg[17:0] reg_r;    // Remainder
    
    wire [15:0] add_sub;
    wire g_or       = reg_d[31] | reg_d[30];    // or gate
    wire g_xnor     = reg_d[31] ~^reg_d[30];    // xnor gate
    wire g_not      = ~reg_d[30];               // not gate
    wire [17:0] r18 = {add_sub, g_xnor, g_not};
    
    // clas16 (a, b, ci, s)
    CLA_16_TOP cla(reg_r[15:0], reg_q ^ {16{~reg_r[17]}}, g_or, add_sub);
    
    always@(posedge clk or negedge clrn) begin
        if(!clrn) begin
            busy <= 0;
            ready <= 0;
        end else begin
            if(start) begin
                reg_d <= d; // load d
                reg_q <= 0;
                reg_r <= 0;
                busy <= 1;
                ready <= 0;
                count <= 0;
            end else if(busy) begin
                reg_d <= {reg_d[29:0],2'b0};            // << 2
                reg_q <= {reg_q[14:0],~add_sub[15]};    // << 1
                reg_r <= r18;
                count <= count + 4'b1;      // count++
                
                if(count == 4'hf) begin    // finish
                    busy <= 0;
                    ready <= 1;             // q,r ready
                end
            end
        end
    end
    
    assign q = reg_q;
    assign r = reg_r[17] ? (reg_r[16:0] + {reg_q[15:0],1'b1}) : reg_r[16:0]; // Adjust remainder
endmodule
