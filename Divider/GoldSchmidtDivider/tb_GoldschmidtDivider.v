`timescale 1ns / 1ps

module tb_GoldschmidtDivider();
    reg clk, clrn;        // Clock and Reset
    reg [31:0] a, b;      // Dividend and Divisor
    reg start;            // Start signal
    wire [31:0] q;        // Quotient
    wire busy;            // Calculation continues                
    wire ready;
    wire [31:0] yn;
    
    GoldschmidtDivider divider(clk, clrn, 
                               a, b,
                               start,   
                               q,
                               busy,     
                               ready, 
                               yn);
    
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
        
        a = 32'hC000_0000;  // 0.75
        b = 32'h8000_0000;  // 0.5
        #10;
        
        start = 1'b1;
        #10;
        start = 1'b0;
    end

endmodule
