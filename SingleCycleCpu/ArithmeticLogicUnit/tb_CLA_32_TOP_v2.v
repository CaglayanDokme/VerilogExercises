`timescale 1ns / 1ps

module tb_CLA_32_TOP_v2();

    reg [31:0] a, b;
    reg ci;     
    wire [31:0] s;
    wire overflow;
    
    CLA_32_TOP_v2 cla32_dut(a, b, ci, s, overflow);
    
    initial begin
        ci = 1'b0;
        a = 32'd3;
        b = 32'd5;
        #10;
        
        a = 32'd0;
        b = 32'hFFFF_FFFF;
        #10;
        
        a = 32'd1;
        b = 32'hFFFF_FFFF;
        #10;
    end
    
endmodule
