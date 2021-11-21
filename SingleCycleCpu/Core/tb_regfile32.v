`timescale 1ns / 1ps

module tb_regfile32();

    reg clk;     // Clock
    reg clrn;    // Reset (Active-Low)
    
    // Read
    reg  [5:0]  readOffset1;     // Read offset
    reg  [5:0]  readOffset2;     // Another read offset
    wire [31:0] readData1;       // Read data
    wire [31:0] readData2;       // Another read data
    
    // Write
    reg [31:0] writeData;            // Data to be written
    reg [5:0]  writeOffset;          // Write offset
    reg        writeEnable;
    
    regfile32 regfile(  clk, clrn,
                        readOffset1,
                        readOffset2,
                        readData1,  
                        readData2,  
                        writeData,  
                        writeOffset,
                        writeEnable);
                
    initial begin
        clk         = 1'b1;
        clrn        = 1'b1;
        writeEnable = 1'b0;
        readOffset1 = 32'h0000_0000;
        readOffset2 = 32'h0000_0000;
        writeData   = 32'h0000_0000;  
        writeOffset = 6'b00_0000;
        writeEnable = 1'b0; 
    end    
    
    always #5 clk = ~clk;
    
    initial begin
        #20;    // Initial wait
        
        // Write
        writeData   = 32'hABCD_EF00;
        writeOffset = 6'b00_0010;
        writeEnable = 1'b1;
        #10;
        
        // Write
        writeData   = 32'h0123_4567;
        writeOffset = 6'b00_0100;
        writeEnable = 1'b1;
        #30;
        writeEnable = 1'b0;
        
        // Read same address
        readOffset1 = 6'b00_0010;
        readOffset2 = 6'b00_0100;
        #20;
        
        // Write
        writeData   = 32'h0101_0202;
        writeOffset = 6'b01_0010;
        writeEnable = 1'b1;
        #10;
        
        // Write
        writeData   = 32'hABAB_CDCD;
        writeOffset = 6'b00_1100;
        writeEnable = 1'b1;
        #30;
        writeEnable = 1'b0;
        
        // Read same address
        readOffset1 = 6'b01_0010;
        readOffset2 = 6'b00_1100;
        #20;
        
    end
endmodule
