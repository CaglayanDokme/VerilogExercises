`timescale 1ns / 1ps

module tb_SquareRoot_Restoring();

    reg clk, clrn;
    reg start;
    reg [31:0] d;
    wire[15:0] q;
    wire[16:0] r;
    wire busy, ready;
    
    SquareRoot_Restoring sqrt(clk, clrn, start, d, q, r, busy, ready);
    
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
        
        d = 32'd40_000_000; // q = 25, r = 5
        #10;
        
        start = 1'b1;
        #10;
        start = 1'b0;      
    end
endmodule
