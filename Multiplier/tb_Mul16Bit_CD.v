`timescale 1ns / 1ps

module tb_Mul16Bit_CD();
    
    reg clk;
    reg start;
    reg [15:0] a,b;
    wire [31:0] result;
    wire resultValid;
    
    Mul16Bit_CD mul1(clk, start, a, b, result, resultValid);
    
    // Clock
    always begin
        clk = 1'b0;
        #5;
        clk = 1'b1;
        #5;
    end
    
    initial begin
        a = 16'd0;
        b = 16'd0;
        start = 1'b0;    
        #40;
        
        a = 16'd35689;
        b = 16'd3756;
        #20;
        
        start = 1'b1;
        #10;
        start = 1'b0;
    end
endmodule
