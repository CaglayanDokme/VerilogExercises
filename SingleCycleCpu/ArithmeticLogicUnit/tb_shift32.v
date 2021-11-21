`timescale 1ns / 1ps

module tb_shift32();

    reg  [31:0]   d;   
    reg  [4:0]    sa;  
    reg           right;
    reg           arith;
    wire [31:0]   sh;
    
    shift32 shifter(d, sa, right, arith, sh);
    
    initial begin
        // Logical right shift
        right   = 1'b1;
        arith   = 1'b0;
        d       = 32'hFFAA_DDBB;
        sa      = 5'd8;
        #10;        
        
        // Logical Left shift
        right = 1'b0;
        arith = 1'b0;
        d       = 32'hFFAA_DDBB;
        sa      = 5'd8;
        #10;        
        
        // Arithmetic right shift
        right = 1'b1;
        arith = 1'b1;
        d       = 32'h8012_4567;
        sa      = 5'd4;
        #10;        
        
        // Arithmetic left shift
        right = 1'b0;
        arith = 1'b1;
        d       = 32'h80AB_CDEF;
        sa      = 5'd4;
        #10;        
    end
endmodule
