//////////////////////////////////////////////////////////////////////////////////
// Engineer: 	Caglayan DOKME
// Create Date: 09.05.2020
// Module Name: 32-Bit Shift Register
// Description: 
// Revision:
// 09.05.2020 -> Revision 0.01 - Created                        (Verificated)
// 12.06.2020 -> Revision 0.02 - Arithmetic left shift added.   (Verificated)
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module shift32( input  [31:0]   d,
                input  [4:0]    sa,         // Shift amount
                input           right,      // 0: Left, 1: Right
                input           arith,      // Shift with sign
                output [31:0]   sh );
                
    reg[31:0] r_sh;
    
    always @* begin
        // Right shift
        if(right) begin
            // Arithmetic right shift
            if(arith) begin
                r_sh = $signed(d) >>> sa;
            // Logical right shift
            end else begin
                r_sh = d >> sa;
            end            
            
        // Left Shift
        end else begin
            // Arithmetic left shift
            if(arith) begin
                r_sh = {d[31], (d[30:0] << sa)};
            // Logical left shift
            end else begin
                r_sh = d << sa;
            end
        end
    end
    
    assign sh = r_sh;               
endmodule
