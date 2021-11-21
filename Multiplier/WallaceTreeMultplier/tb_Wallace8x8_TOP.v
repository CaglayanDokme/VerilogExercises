`timescale 1ns / 1ps

module tb_Wallace8x8_TOP();
    reg  [07:00] a, b;
    wire [15:00] z;

    Wallace8x8_TOP wallace8(a, b, z);

    initial begin
        a = 8'h00;
        b = 8'h01;
        #5;
        
        a = 8'hFF;
        b = 8'h02;
        #5;
                
        a = 8'hFF;
        b = 8'h04;
        #5;
        
        a = 8'hFF;
        b = 8'h08;
        #5;
        
        a = 8'hFF;
        b = 8'h10;
        #5;
        
        a = 8'hFF;
        b = 8'h20;
        #5;
        
        a = 8'hFF;
        b = 8'h40;
        #5;
        
        a = 8'hFF;
        b = 8'hFF;
        #5;

    end
endmodule
