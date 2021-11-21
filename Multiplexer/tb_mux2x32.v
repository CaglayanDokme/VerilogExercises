`timescale 1ns / 1ps

module tb_mux2x32();

    reg[31:0] a0, a1;
    reg selection;
    wire[31:0] y;
    

mux2x32 mux(a0, a1, selection, y);

    initial begin 
        a0 = 32'h1111_2222;
        a1 = 32'hAAAA_BBBB;
        selection = 1'b0;
        #20;
        
        selection = 1'b1;
        #20;
        
        
        a0 = 32'hFFFF_DDDD;
        a1 = 32'hEEEE_CCCC;
    end
endmodule
