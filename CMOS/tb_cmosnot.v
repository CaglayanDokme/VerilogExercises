`timescale 1ns / 1ps

module tb_cmosnot;
    reg a;
    wire f;
    
    cmosnot cmos_not(f, a);
    
    initial begin
        a = 0;
        #1 a = 1;
        #1 a = 0;
        #1 $finish;
    end
    
    initial begin
        $monitor("%2d:\t = %b\tf = %b", $time, a, f);
    end

endmodule
