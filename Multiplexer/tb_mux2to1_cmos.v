`timescale 1ns / 1ns

module tb_mux2to1_cmos;

    reg s, a0, a1;
    wire y;
    
    mux2to1_cmos mux2to1(s, a0, a1, y);
    
    initial begin
        a0 = 0;
        a1 = 0;
        s  = 0;
        
        $display("time\ts\ta1\ta0\ty");
        $monitor("%2d:\t\t%b\t%b\t%b\t%b", $time, s, a1, a0, y);
    end
    
    always #1 a0 = !a0;
    always #2 a1 = !a1;
    always #4 s = !s;
endmodule
