`timescale 1ns / 1ps

module tb_SquareRoot_Goldschmidt();

    reg clk, clrn;
    reg start;
    reg [31:0] d;
    wire[31:0] q, xn;
    wire busy, ready;
    
    SquareRoot_Goldschmidt sqrt(clk, clrn, start, d, q, xn, busy, ready);
    
    // Clock
    always begin
       clk = 1'b1;
       #5;
       clk = 1'b0;
       #5;
    end
    
    initial begin
        clrn = 1'b1;
        #10;
        
        d = 32'h40000000; 
        #10;
        
        start = 1'b1;
        #10;
        start = 1'b0;      
    end
endmodule
