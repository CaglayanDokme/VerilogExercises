`timescale 1ns / 1ps
module tb_dff32();

    reg clk;           
    reg clrn;           
    reg [31:0] nextValue;
    wire [31:0] oldValue;
    
    dff32 register(clk, clrn, nextValue, oldValue);

    initial begin
        clk     = 1'b0;
        clrn    = 1'b1;
    end
    
    always #5 clk = ~clk;
    
    initial begin
        #10;
        nextValue = 32'hABCD_EF00;
        #13;
        nextValue = 32'h0101_0202;
        #10;
    end
endmodule
