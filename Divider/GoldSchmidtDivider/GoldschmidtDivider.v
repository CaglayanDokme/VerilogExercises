//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 29.05.2020
// Module Name: Goldschmidt Division Algorithm Module
// Description: Calculates A/B for 0.5 <= A, B < 1
//              e.g. A = 0xC000_0000 = 0.75
//              e.g. B = 0x8000_0000 = 0.50
// Revision:
// 29.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module GoldschmidtDivider(
    input clk, clrn,        // Clock and Reset
    input [31:0] a, b,      // Dividend and Divisor
    input start,            // Start signal
    output [31:0] q,        // Quotient
    output reg busy,        // Calculation continues                
    output reg ready,       // Ready
    output [31:0] yn);      
    
    reg[63:0] reg_a, reg_b; // REG_A: x.xxx..x, REG_B: 0.xxx..x
    reg[2:0] count;
    
    wire[63:0] two_minus_yi = ~reg_b + 1'b1;
    wire[127:0] xi = reg_a * two_minus_yi;
    wire[127:0] yi = reg_b * two_minus_yi;
    
    always@(posedge(clk) or negedge(clrn)) begin
        if(!clrn) begin
            busy <= 0;
            ready <= 0;
        end else begin
            if(start) begin
                reg_a   <= {1'b0, a, 31'b0};
                reg_b   <= {1'b0, b, 31'b0}; // 0.1x...x0...0
                busy    <= 1;
                ready   <= 0;
                count   <= 0;
            end else begin
                reg_a <= xi[126:63];    // x.xxx...x
                reg_b <= yi[126:63];    // 0.xxx...x
                count <= count + 3'b1;  // count++
                
                if (count == 3'h4) begin // finish
                    busy    <= 0;
                    ready   <= 1;     // q is ready
                end
            end
        end
    end    
    
    assign q    = reg_a[63:32] + |reg_a[31:29];
    assign yn   = reg_b[61:31];
endmodule
