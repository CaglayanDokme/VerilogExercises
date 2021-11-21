//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 11.06.2020
// Module Name: Primer Arithmetic Logic Unit 
// Description: Figure 4.13
// Control Bits: X000 - ADD
//               X100 - SUB
//               X001 - AND                         
//               X101 - OR                          
//               X010 - XOR                         
//               X110 - LUI : Load Upper Immediate  
//               0011 - SLL : Shift Left Logical    
//               0111 - SRL : Shift Right Logical 
//               1011 - SLA : Shift Left Arithmetic  
//               1111 - SRA : Shift Right Arithmetic
// Revision:
// 11.06.2020 -> Revision 0.01 - Created                        (Verificated)
// 12.06.2020 -> Revision 0.02 - Overflow flag added.           (Verificated)
// 12.06.2020 -> Revision 0.03 - Arithmetic Left Shift added.   (Verificated)
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module ALU( input  [31:0]   a, b,
            input  [3:0]    control,
            output [31:0]   result,
            output          zeroFlag,
            output          overflow);
            
    wire[31:0] d_and        = a & b;                        
    wire[31:0] d_or         = a | b;                        
    wire[31:0] d_xor        = a ^ b;                        
    wire[31:0] d_lui        = {b[15:0], 16'h0};             
    wire[31:0] d_and_or     = control[2] ? d_or : d_and;    
    wire[31:0] d_xor_lui    = control[2] ? d_lui : d_xor;   
    wire[31:0] d_as, d_sh;                                  
    
    // ADDSUB_32 (a, b, sub, s)
    AddSub_32Bit AddSub(a, b, control[2], d_as, overflow);
    
    // Shift (d, sa, right, arith, sh)
    shift32 shifter(b, a[4:0], control[2], control[3], d_sh);
    
    // Mux 4 to 32 (a0, a1, a2, a3, s, y)
    mux4to1_32bit mux(d_as, d_and_or, d_xor_lui, d_sh, control[1:0], result);   // ALU Result chooser mux
    
    assign zeroFlag = ~|result;    // result =? 0
endmodule
