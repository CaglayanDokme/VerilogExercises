//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 27.05.2020
// Module Name: Submodule of 8-Bit Wallace Tree Multplier
// Description: A top module should be used calculate the final result.
// Revision:
// 27.05.2020 -> Revision 0.01 - Created    (Verificated)
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module Wallace8x8(
    input  [07:00] a, b,
    output [15:05] x, y,
    output [04:00] z);
    
    reg [07:00] p [07:00]; // p[i][j]
    parameter zero = 1'b0; // constant 0
    integer i, j;
    
    always @ * begin
        for (i = 0; i < 8; i = i + 1)
            for (j = 0; j < 8; j = j + 1)
                p[i][j] = a[i] & b[j];
    end
    
    // level 1 ------------------------------------------------------------
    wire [2:0] s1 [12:1];
    wire [2:0] c1 [13:2];
    // 15:
    // 14: p[07][07]
    // 13: p[06][07], p[07][06]
    fullAdder_Behavioral a1_12_0 (p[05][07], p[06][06], p[07][05], s1[12][0], c1[13][0]);
    fullAdder_Behavioral a1_11_0 (p[04][07], p[05][06], p[06][05], s1[11][0], c1[12][0]);
    // 11: p[07][04]
    fullAdder_Behavioral a1_10_1 (p[03][07], p[04][06], p[05][05], s1[10][1], c1[11][1]);
    fullAdder_Behavioral a1_10_0 (p[06][04], p[07][03], zero, s1[10][0], c1[11][0]);
    fullAdder_Behavioral a1_09_1 (p[02][07], p[03][06], p[04][05], s1[09][1], c1[10][1]);
    fullAdder_Behavioral a1_09_0 (p[05][04], p[06][03], p[07][02], s1[09][0], c1[10][0]);
    fullAdder_Behavioral a1_08_1 (p[01][07], p[02][06], p[03][05], s1[08][1], c1[09][1]);
    fullAdder_Behavioral a1_08_0 (p[04][04], p[05][03], p[06][02], s1[08][0], c1[09][0]);
    // 08: p[07][01]
    fullAdder_Behavioral a1_07_2 (p[00][07], p[01][06], p[02][05], s1[07][2], c1[08][2]);
    fullAdder_Behavioral a1_07_1 (p[03][04], p[04][03], p[05][02], s1[07][1], c1[08][1]);
    fullAdder_Behavioral a1_07_0 (p[06][01], p[07][00], zero, s1[07][0], c1[08][0]);
    fullAdder_Behavioral a1_06_1 (p[00][06], p[01][05], p[02][04], s1[06][1], c1[07][1]);
    fullAdder_Behavioral a1_06_0 (p[03][03], p[04][02], p[05][01], s1[06][0], c1[07][0]);
    // 06: p[06][00]
    fullAdder_Behavioral a1_05_1 (p[00][05], p[01][04], p[02][03], s1[05][1], c1[06][1]);
    fullAdder_Behavioral a1_05_0 (p[03][02], p[04][01], p[05][00], s1[05][0], c1[06][0]);
    fullAdder_Behavioral a1_04_1 (p[00][04], p[01][03], p[02][02], s1[04][1], c1[05][1]);
    fullAdder_Behavioral a1_04_0 (p[03][01], p[04][00], zero, s1[04][0], c1[05][0]);
    fullAdder_Behavioral a1_03_0 (p[00][03], p[01][02], p[02][01], s1[03][0], c1[04][0]);
    // 03: p[03][00]
    fullAdder_Behavioral a1_02_0 (p[00][02], p[01][01], p[02][00], s1[02][0], c1[03][0]);
    fullAdder_Behavioral a1_01_0 (p[00][01], p[01][00], zero, s1[01][0], c1[02][0]);
    // 00: p[00][00]
    // level 2 ------------------------------------------------------------
    wire [1:0] s2 [13:2];
    wire [1:0] c2 [14:3];
    // 15:
    // 14: p[07][07]
    fullAdder_Behavioral a2_13_0 (p[06][07], p[07][06], c1[13][0], s2[13][0], c2[14][0]);
    fullAdder_Behavioral a2_12_0 (s1[12][0], c1[12][0], zero, s2[12][0], c2[13][0]);
    fullAdder_Behavioral a2_11_0 (s1[11][0], p[07][04], c1[11][1], s2[11][0], c2[12][0]);
    // 11: c1[11][0]
    fullAdder_Behavioral a2_10_0 (s1[10][1], s1[10][0], c1[10][1], s2[10][0], c2[11][0]);
    // 10: c1[10][0]
    fullAdder_Behavioral a2_09_0 (s1[09][1], s1[09][0], c1[09][1], s2[09][0], c2[10][0]);
    // 09: c1[09][0]
    fullAdder_Behavioral a2_08_1 (s1[08][1], s1[08][0], p[07][01], s2[08][1], c2[09][1]);
    fullAdder_Behavioral a2_08_0 (c1[08][2], c1[08][1], c1[08][0], s2[08][0], c2[09][0]);
    fullAdder_Behavioral a2_07_1 (s1[07][2], s1[07][1], s1[07][0], s2[07][1], c2[08][1]);
    fullAdder_Behavioral a2_07_0 (c1[07][1], c1[07][0], zero, s2[07][0], c2[08][0]);
    fullAdder_Behavioral a2_06_1 (s1[06][1], s1[06][0], p[06][00], s2[06][1], c2[07][1]);
    fullAdder_Behavioral a2_06_0 (c1[06][1], c1[06][0], zero, s2[06][0], c2[07][0]);
    fullAdder_Behavioral a2_05_0 (s1[05][1], s1[05][0], c1[05][1], s2[05][0], c2[06][0]);
    // 05: c1[05][0]
    fullAdder_Behavioral a2_04_0 (s1[04][1], s1[04][0], c1[04][0], s2[04][0], c2[05][0]);
    fullAdder_Behavioral a2_03_0 (s1[03][0], p[03][00], c1[03][0], s2[03][0], c2[04][0]);
    fullAdder_Behavioral a2_02_0 (s1[02][0], c1[02][0], zero, s2[02][0], c2[03][0]);
    // 01: s1[01][0]
    // 00: p[00][00]
    // level 3 ------------------------------------------------------------
    wire [0:0] s3 [14:3];
    wire [0:0] c3 [15:4];
    // 15:
    fullAdder_Behavioral a3_14_0 (p[07][07], c2[14][0], zero, s3[14][0], c3[15][0]);
    fullAdder_Behavioral a3_13_0 (s2[13][0], c2[13][0], zero, s3[13][0], c3[14][0]);
    fullAdder_Behavioral a3_12_0 (s2[12][0], c2[12][0], zero, s3[12][0], c3[13][0]);
    fullAdder_Behavioral a3_11_0 (s2[11][0], c1[11][0], c2[11][0], s3[11][0], c3[12][0]);
    fullAdder_Behavioral a3_10_0 (s2[10][0], c1[10][0], c2[10][0], s3[10][0], c3[11][0]);
    fullAdder_Behavioral a3_09_0 (s2[09][0], c1[09][0], c2[09][1], s3[09][0], c3[10][0]);
    // 09: c2[09][0]
    fullAdder_Behavioral a3_08_0 (s2[08][1], s2[08][0], c2[08][1], s3[08][0], c3[09][0]);
    // 08: c2[08][0]
    fullAdder_Behavioral a3_07_0 (s2[07][1], s2[07][0], c2[07][1], s3[07][0], c3[08][0]);
    // 07: c2[07][0]
    fullAdder_Behavioral a3_06_0 (s2[06][1], s2[06][0], c2[06][0], s3[06][0], c3[07][0]);
    fullAdder_Behavioral a3_05_0 (s2[05][0], c1[05][0], c2[05][0], s3[05][0], c3[06][0]);
    fullAdder_Behavioral a3_04_0 (s2[04][0], c2[04][0], zero, s3[04][0], c3[05][0]);
    fullAdder_Behavioral a3_03_0 (s2[03][0], c2[03][0], zero, s3[03][0], c3[04][0]);
    // 02: s2[02][0]
    // 01: s1[01][0]
    // 00: p[00][00]
    // level 4 ------------------------------------------------------------
    wire [0:0] s4 [14:4];
    wire [0:0] c4 [15:5];
    // 15: c3[15][0]
    fullAdder_Behavioral a4_14_0 (s3[14][0], c3[14][0], zero, s4[14][0], c4[15][0]);
    fullAdder_Behavioral a4_13_0 (s3[13][0], c3[13][0], zero, s4[13][0], c4[14][0]);
    fullAdder_Behavioral a4_12_0 (s3[12][0], c3[12][0], zero, s4[12][0], c4[13][0]);
    fullAdder_Behavioral a4_11_0 (s3[11][0], c3[11][0], zero, s4[11][0], c4[12][0]);
    fullAdder_Behavioral a4_10_0 (s3[10][0], c3[10][0], zero, s4[10][0], c4[11][0]);
    fullAdder_Behavioral a4_09_0 (s3[09][0], c2[09][0], c3[09][0], s4[09][0], c4[10][0]);
    fullAdder_Behavioral a4_08_0 (s3[08][0], c2[08][0], c3[08][0], s4[08][0], c4[09][0]);
    fullAdder_Behavioral a4_07_0 (s3[07][0], c2[07][0], c3[07][0], s4[07][0], c4[08][0]);
    fullAdder_Behavioral a4_06_0 (s3[06][0], c3[06][0], zero, s4[06][0], c4[07][0]);
    fullAdder_Behavioral a4_05_0 (s3[05][0], c3[05][0], zero, s4[05][0], c4[06][0]);
    fullAdder_Behavioral a4_04_0 (s3[04][0], c3[04][0], zero, s4[04][0], c4[05][0]);
    // 03: s3[03][0]
    // 02: s2[02][0]
    // 01: s1[01][0]
    // 00: p[00][00]
    assign x[15] = c3[15][0]; assign y[15] = c4[15][0];
    assign x[14] = s4[14][0]; assign y[14] = c4[14][0];
    assign x[13] = s4[13][0]; assign y[13] = c4[13][0];
    assign x[12] = s4[12][0]; assign y[12] = c4[12][0];
    assign x[11] = s4[11][0]; assign y[11] = c4[11][0];
    assign x[10] = s4[10][0]; assign y[10] = c4[10][0];
    assign x[09] = s4[09][0]; assign y[09] = c4[09][0];
    assign x[08] = s4[08][0]; assign y[08] = c4[08][0];
    assign x[07] = s4[07][0]; assign y[07] = c4[07][0];
    assign x[06] = s4[06][0]; assign y[06] = c4[06][0];
    assign x[05] = s4[05][0]; assign y[05] = c4[05][0];
    assign z[04] = s4[04][0];
    assign z[03] = s3[03][0];
    assign z[02] = s2[02][0];
    assign z[01] = s1[01][0];
    assign z[00] = p[00][00];    
endmodule
