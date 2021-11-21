//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 02.07.2020
// Module Name: 32-Bit Single Cycle CPU Core 
// Description: Figure 5.19
// Revision:
// 02.07.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module SingleCycleCPU(input clk,
                      input clrn,
                      input  [31:0] instruction,    // Instruction input
                      input  [31:0] dataFromMem,    // Data fetched from data memory unit
                      output [31:0] progCounter,    // Program counter
                      output        writeToMem,     // Enable flag for write to memory 
                      output [31:0] aluOut,         // Output of ALU
                      output [31:0] dataToMem);     // Data written to memory

    // Instruction Fields (Decode)                      
    wire [05:0] opCode   = instruction[31:26];
    wire [04:0] rs       = instruction[25:21];
    wire [04:0] rt       = instruction[20:16];
    wire [04:0] rd       = instruction[15:11];
    wire [05:0] func     = instruction[05:00];
    wire [15:0] imm      = instruction[15:00];
    wire [25:0] addr     = instruction[25:00];
    
    // Control Signals   
    wire [3:0]  aluc;       // ALU Operation Control
    wire [1:0]  pcSrc;      // Select PC Source                 00: Select PC+4         01: Branch Address      10: Register Data       11: Jump Address
    wire        wreg;       // Write Register File              1: Write                0: Don't write
    wire        regrt;      // Destination register number      1: Select rt            0: Select rd
    wire        m2reg;      // Instruction is an LW             1: Select memory data   0: Select ALU result
    wire        shift;      // Instruction is a shift           1: Select sa            0: Select register data
    wire        aluimm;     // ALU input B is an immediate      1: Select immediate     0: Select register data
    wire        jal;        // Instruction is a JAL             1: is JAL               0: Is not JAL     (JAL: Jump and link, used in subroutine call)
    wire        sext;       // Sign extension                   1: Sign extend          0: Zero extend
    
    // Datapath wires
    wire [31:0] pc_p4;      // PC + 4
    wire [31:0] bpc;        // Branch target address
    wire [31:0] npc;        // Next PC
    wire [31:0] qa;         // Regfile output a port
    wire [31:0] qb;         // Regfile output b port
    wire [31:0] alua;       // ALU input a
    wire [31:0] alub;       // ALU input b
    wire [31:0] wd;         // Regfile write data port
    wire [31:0] r;          // ALU out or mem
    wire [04:0] regDest;    // RS or RT
    wire        z;          // ALU, zero tag
    wire        overFlow;   // ALU, overflow flag
    wire [04:0] wn  = regDest | {5{jal}};                   // Regfile write reg #
    wire [31:0] sa  = {27'b0, instruction[10:6]};           // Shift amount
    wire [15:0] s16 = {16{sext & instruction[15]}};         // 16 Signs
    wire [31:0] i32 = {s16, imm};                           // 32-Bit immedidiate
    wire [31:0] dis = {s16[13:0], imm, 2'b00};              // Word distance
    wire [31:0] jpc = {pc_p4[31:28], addr, 2'b00};          // Jump target address
    
    // Control Unit
    SingleCycleControlUnit controlUnit(opCode,  func,   z,      writeToMem,   
                                       regrt,   m2reg,  aluc,   shift,
                                       wreg,    aluimm, pcSrc,  jal,    sext);
                                       
    // Datapath
    dff32       i_point (clk,           clrn,           npc,        progCounter);       // PC Register
    CLA_32_TOP  pcplus4 (progCounter,   32'h4,          1'b0,       pc_p4);             // PC + 4
    CLA_32_TOP  br_addr (pc_p4,         dis,            1'b0,       bpc);               // Branch target address
    mux2x32     alu_a   (qa,            sa,             shift,      alua);              // ALU input a          
    mux2x32     alu_b   (qb,            i32,            aluimm,     alub);              // ALU input b
    mux2x32     alu_m   (aluOut,        dataFromMem,    m2reg,      r);                 // ALU out or mem
    mux2x32     link    (r,             pc_p4,          jal,        wd);                // ALU input a                             
    mux2x5      reg_wn  (rd,            rt,             regrt,      regDest);           // RS or RT
    mux4x32     nextpc  (pc_p4, bpc,    qa, jpc,        pcSrc,      npc);               // Next PC Selection
    regfile32   regfile (clk, clrn,     rs, rt,         qa, qb,     wd, wn, wreg);      // Register file
    ALU         alunit  (alua, alub,    aluc,           aluOut, z,  overFlow);          // Arithmetic Logic Unit
    
    assign dataToMem = qb;
    
endmodule
