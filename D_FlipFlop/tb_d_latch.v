`timescale 1ns / 1ps

module tb_d_latch;

    reg c, d;
    wire q, qn;
    
    d_latch d_latch1(c, d, q, qn);
    
    initial begin
        c = 1'b1;
        d = 1'b1;
        #5;
        
        
        c = 1'b1;
        d = 1'b0;
        #5;
        
        c = 1'b0;
        d = 1'b1;
        #5;
        
        c = 1'b0;
        d = 1'b0;
        #5;
    end

endmodule
