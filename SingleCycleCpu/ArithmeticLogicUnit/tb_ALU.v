`timescale 1ns / 1ps

module tb_ALU();

    reg [31:0]  a, b;   
    reg [3:0]   control;
    wire[31:0]  result;
    wire        zeroFlag;
    wire        overflow;            
    
    ALU alu(a, b, control, result, zeroFlag, overflow);

    initial begin
        control = 4'b0000;     // ADD
        a       = 32'd1;
        b       = 32'd2;
        #10;
        
        control = 4'b0000;     // ADD with overflow
        a       = 32'hFFFF_FFFF;
        b       = 32'h0000_0001;
        #10;
        
        control = 4'b0100;  // SUB
        a       = 32'd2;
        b       = 32'd1;
        #10;
        
        control = 4'b0100;  // SUB with zeroflag
        a       = 32'd2;
        b       = 32'd2;
        #10;
        
        control = 4'b0100;  // SUB with overflow
        a       = 32'd2;
        b       = 32'd3;
        #10;
        
        control = 4'b0001;  // AND
        a       = 32'hCCCC_CCCC;
        b       = 32'hAAAA_AAAA;
        #10; 
        
        control = 4'b0101;  // OR 
        a       = 32'hCCCC_CCCC;
        b       = 32'hAAAA_AAAA;
        #10;
        
        control = 4'b0010;  // XOR
        a       = 32'h3333_3333;
        b       = 32'hff00_5555;
        #10;
        
        control = 4'b0110;  // LUI
        a       = 32'h3333_3333;
        b       = 32'hff00_5555;
        #10;
        
        control = 4'b0011;  // SLL
        a       = 32'h0000_000F;
        b       = 32'hFFFF_FFFF;
        #10;  
                
        control = 4'b0111;  // SRL 
        a       = 32'h0000_000F;
        b       = 32'hFFFF_FFFF;
        #10;
        
        control = 4'b1011;  // SLA 
        a       = 32'h0000_0004;
        b       = 32'h80AB_CDEF;
        #10;
        
        control = 4'b1111;  // SRA
        a       = 32'h0000_0010;
        b       = 32'h7F00_0000;
        #10;
        
        control = 4'b1111;  // SRA Again
        a       = 32'h0000_0010;
        b       = 32'hFFFF_FF00;
        #10;        
    end
    
endmodule
