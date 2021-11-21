`timescale 1ns / 1ps

module ALU_Behavioral(  input  [31:0]   a, b,
                        input  [3:0]    control,
                        output [31:0]   result,
                        output          zeroFlag,
                        output          overflow);
                        
    reg[31:0] r_result;
    
    wire[31:0] addSubResult, shiftResult;
    
    // ADDSUB_32 (a, b, sub, s)
    AddSub_32Bit AddSub(a, b, control[2], addSubResult, overflow);
    
    // Shift (d, sa, right, arith, sh)
    shift32 shifter(b, a[4:0], control[2], control[3], shiftResult);
    
    always@(a or b or control) begin
        r_result = 32'h0000_0000;
    
        casex(control)
            4'bx000: r_result = addSubResult; 
            4'bx100: r_result = addSubResult;
            4'bx001: r_result = a & b;
            4'bx101: r_result = a | b;
            4'bx010: r_result = a ^ b;
            4'bx110: r_result = {b[15:0], 16'b0};
            4'b0011: r_result = shiftResult;
            4'b0111: r_result = shiftResult;
            4'b1111: r_result = shiftResult;
            default: r_result = 32'hDEAD_BEEF;
        endcase
    end
    
    assign result   = r_result;
    assign zeroFlag = ~|r_result;    
endmodule
