//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 09.05.2020
// Module Name: DFF using two D-Latches (Academic Version)
// Description: 
// Revision:
// 09.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module d_flip_flop(
    input clk,
    input d,
    output q,
    output qn
    );

// Internal wires
wire q0, q0n;
wire clkn, clknn;

// NOT(OUT, IN)
not inv1(clkn, clk);
not inv2(clknn, clkn);

// D_LATCH(c, d, q, qn)
d_latch d_latch1(clkn, d, q0 ,q0n);     // Master D-Latch
d_latch d_latch2(clknn, q0, q ,qn);     // Slave D-Latch
    
endmodule
