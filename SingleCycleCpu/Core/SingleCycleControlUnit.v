//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 02.07.2020
// Module Name: 32-Bit Single Cycle Computer Control Unit 
// Description: Table 5.3
// Revision:
// 02.07.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module SingleCycleControlUnit(input  [5:0] opCode, func,
                              input  z,
                              output writeToMem,
                              output regrt,
                              output m2reg,
                              output [3:0] aluc,
                              output shift,
                              output wreg,
                              output aluimm,
                              output [1:0] pcSrc,
                              output jal,
                              output sext);
                              
    // Decode instructions
    wire rtype = ~|opCode;  // Operate OR on all bits of opCode and revet it. (All bits should be '0')
    
    // R Format
    wire i_add = rtype &  func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0];                                   
    wire i_sub = rtype &  func[5] & ~func[4] & ~func[3] & ~func[2] &  func[1] & ~func[0];    
    wire i_and = rtype &  func[5] & ~func[4] & ~func[3] &  func[2] & ~func[1] & ~func[0];    
    wire i_or  = rtype &  func[5] & ~func[4] & ~func[3] &  func[2] & ~func[1] &  func[0];    
    wire i_xor = rtype &  func[5] & ~func[4] & ~func[3] &  func[2] &  func[1] & ~func[0];    
    wire i_sll = rtype & ~func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0];    
    wire i_srl = rtype & ~func[5] & ~func[4] & ~func[3] & ~func[2] &  func[1] & ~func[0];    
    wire i_sra = rtype & ~func[5] & ~func[4] & ~func[3] & ~func[2] &  func[1] &  func[0];    
    wire i_jr  = rtype & ~func[5] & ~func[4] &  func[3] & ~func[2] & ~func[1] & ~func[0];
    
    // I Format
    wire i_addi = ~opCode[5] & ~opCode[4] &  opCode[3] & ~opCode[2] & ~opCode[1] & ~opCode[0];    
    wire i_andi = ~opCode[5] & ~opCode[4] &  opCode[3] &  opCode[2] & ~opCode[1] & ~opCode[0];     
    wire i_ori  = ~opCode[5] & ~opCode[4] &  opCode[3] &  opCode[2] & ~opCode[1] &  opCode[0];     
    wire i_xori = ~opCode[5] & ~opCode[4] &  opCode[3] &  opCode[2] &  opCode[1] & ~opCode[0];     
    wire i_lw   =  opCode[5] & ~opCode[4] & ~opCode[3] & ~opCode[2] &  opCode[1] &  opCode[0];     
    wire i_sw   =  opCode[5] & ~opCode[4] &  opCode[3] & ~opCode[2] &  opCode[1] &  opCode[0];     
    wire i_beq  = ~opCode[5] & ~opCode[4] & ~opCode[3] &  opCode[2] & ~opCode[1] & ~opCode[0];     
    wire i_bne  = ~opCode[5] & ~opCode[4] & ~opCode[3] &  opCode[2] & ~opCode[1] &  opCode[0];     
    wire i_lui  = ~opCode[5] & ~opCode[4] &  opCode[3] &  opCode[2] &  opCode[1] &  opCode[0];
    
    // J Format     
    wire i_jump = ~opCode[5] & ~opCode[4] & ~opCode[3] & ~opCode[2] &  opCode[1] & ~opCode[0];     
    wire i_jal  = ~opCode[5] & ~opCode[4] & ~opCode[3] & ~opCode[2] &  opCode[1] &  opCode[0];  
    
    // Generate control signals
    assign writeToMem   = i_sw;
    assign regrt        = i_addi | i_andi | i_ori | i_xori | i_lw | i_lui;
    assign m2reg        = i_lw;
    assign aluc[3]      = i_sra;
    assign aluc[2]      = i_sub  | i_or   | i_srl  | i_sra  | i_ori  | i_lui;
    assign aluc[1]      = i_xor  | i_sll  | i_srl  | i_sra  | i_xori | i_beq  | i_bne | i_lui;
    assign aluc[0]      = i_and  | i_or   | i_sll  | i_srl  | i_sra  | i_andi | i_ori;
    assign shift        = i_sll  | i_srl  | i_sra;
    assign wreg         = i_add  | i_sub  | i_and  | i_or   | i_xor  | i_sll  |
                          i_srl  | i_sra  | i_addi | i_andi | i_ori  | i_xori |
                          i_lw   | i_lui  | i_jal;
    assign aluimm       = i_addi | i_andi | i_ori  | i_xori | i_lw   | i_lui  | i_sw;
    assign pcSrc[1]     = i_jr   | i_jump | i_jal;
    assign pcSrc[0]     = (i_beq & z)     | (i_bne & ~z)    | i_jump | i_jal;
    assign jal          = i_jal;
    assign sext         = i_addi | i_lw | i_sw | i_beq | i_bne;
    
endmodule
