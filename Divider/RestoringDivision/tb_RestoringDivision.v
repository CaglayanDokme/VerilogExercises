`timescale 1ns / 1ps

module tb_RestoringDivision();

    reg clk, clrn;    // Clock and Reset
    reg [31:0] a;     // Dividend
    reg [15:0] b;     // Divisor
    reg start;        // Start signal
    wire [31:0] q;    // Quotient
    wire [15:0] r;    // Remainder
    wire busy;        // Calculation continues    
    wire ready;       // Ready
    
    RestoringDivision Division(clk, 
                               clrn,     // Clock and Reset
                               a,        // Dividend
                               b,        // Divisor
                               start,    // Start signal
                               q,        // Quotient
                               r,        // Remainder
                               busy,     // Calculation continues    
                               ready); 
        
    // Clock
    always begin
        clk = 1'b1;
        #5;
        clk = 1'b0;
        #5;
    end
                              
    initial begin
        clrn    = 1'b1;
        a       = 32'd0;
        b       = 16'd0;
        start   = 1'b0;
        #20;
        
        a       = 32'h4C7F_228A;
        b       = 16'h6A0E;
        #10;
        
        start = 1'b1;
        #10;
        start = 1'b0;
        
    end
endmodule
