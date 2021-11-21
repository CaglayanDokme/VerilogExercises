//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 09.05.2020
// Module Name: DFF (Industry Version)
// Description: 
// Revision:
// 09.05.2020 -> Revision 0.01 - Created
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module d_flip_flop_v2( 
    input prn,  // Preset
    input clk,  // Clock
    input d,    // Data
    input clrn, // Clear (Active-Low)
    output q,   // Outputs
    output qn
    );
    
wire wire_0, wire_1, wire_2, wire_3;

assign wire_0 = ~(wire_1 & prn  & wire_2);
assign wire_1 = ~(clk    & clrn & wire_0);
assign wire_2 = ~(wire_3 & clrn & d);
assign wire_3 = ~(wire_1 & clk  & wire_2);

assign q    = ~(prn & wire_1 & qn);
assign qn   = ~(q   & wire_3 & clrn);
   
endmodule
