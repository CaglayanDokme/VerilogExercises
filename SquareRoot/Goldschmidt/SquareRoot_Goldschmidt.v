//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 08.06.2020
// Module Name: Goldschmidt Square Root Algorithm Module
// Description: Calculates sqrt(d) = q^2 if 0.25 <= d < 1
// Revision:
// 08.06.2020 -> Revision 0.01 - Created (Validated)
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module SquareRoot_Goldschmidt(
    input clk, clrn,
    input start,
    input [31:0] d,
    output [31:0] q, xn,
    output reg busy, ready);

    reg[2:0] count;
    reg [63:0] reg_d; // 0.1xx or 0.01x
    reg [63:0] reg_x; // 0.1xx or 0.01x
    
    wire [63:0] ri = 64'hc000000000000000 - {1'b0,reg_x[63:1]}; // 1+(1-xi)/2 =(3-xi)/2 1.xx
    wire [127:0] ci = ri * ri; // ri*ri 0x.xx
    wire [127:0] dr1 = reg_d * ri; // d*ri 0x.xx
    wire [127:0] xr2 = reg_x * ci[126:63]; // x*ci 0x.xx
    wire [63:0] xi = {1'b0,{63{xr2[126]}}|xr2[125:63]}; // let xi<1 0.xx
    
    always @ (posedge clk or negedge clrn) begin
        if (!clrn) begin
            busy <= 0;
            ready <= 0;
        end else begin
            if (start) begin
                reg_d   <= {1'b0,d,31'b0}; // 0.1xx...x0. or
                reg_x   <= {1'b0,d,31'b0}; // 0.01x...x0...0
                busy    <= 1;
                ready   <= 0;
                count   <= 0;
            end else begin
                reg_d <= dr1[126:63]; // x.xxx...x
                reg_x <= xi; // 0.xxx...x
                count <= count + 3'b1; // count++
                
                if (count == 3'h5) begin // finish
                    busy    <= 0;
                    ready   <= 1; // q is ready
                end
            end
        end
    end
    
    assign q    = reg_d[62:31] + | reg_d[30:0]; // rounding up
    assign xn   = reg_x[62:31];
endmodule