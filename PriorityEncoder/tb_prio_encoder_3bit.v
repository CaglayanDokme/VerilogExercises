`timescale 1ns / 1ns

module tb_prio_encoder_3bit;

    reg[7:0] d;
    reg ena;
    wire[2:0] n;
    wire g;
    
    prio_encoder_3bit encoder(d, ena, n, g);

    initial begin
        d   = 8'b0000_0000;
        ena = 1;
    end
    
    always #2 d     = {d[6:0], 1'b1};
    always #20 ena  = !ena;

endmodule
