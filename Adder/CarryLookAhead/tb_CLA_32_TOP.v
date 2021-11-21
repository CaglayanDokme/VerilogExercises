//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 27.05.2020
// Module Name: Testbench for top module of 32-Bit Carry Look Ahead Adder 
// Description: To be used as a real 32-Bit adder, the G and P outputs must be removed from CLA_32 module.
// Revision:
// 27.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module tb_CLA_32_TOP();

    reg[31:0] a, b;
    reg ci;
    wire[31:0] sum;
    
    // CLA_32_TOP(a, b, ci, s)
    CLA_32_TOP Adder32Bit(a, b, ci, sum);
    
    initial begin
        a = 32'h00000000;
        b = 32'h00000000;
        ci = 1'b0;
        #10;
        
        a = 32'h0000AAAA;
        b = 32'hBBBB0000;
        ci = 1'b0;
        #10;
        
        a = 32'h0000000F;
        b = 32'h00000001;
        ci = 1'b0;
        #10;
        
        a = 32'hABACADAE;
        b = 32'h01234567;
        ci = 1'b0;
        #10;
                
        a = 32'hF0D0B090;
        b = 32'h0E0C0A08;
        ci = 1'b0;
        #10;
    end

endmodule
