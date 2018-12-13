`timescale 1ns / 1ps
/*
 ******************************************************************************
 * Autor: Ángel Terrones <aterrones@usb.ve>
 * Módulo: Driver 7-segmentos
 ******************************************************************************
 */
module driver(
    input [3:0]      valor_i,
    output [3:0]     anodos_o,
    output reg [7:0] segmentos_o
    );

assign anodos_o = 4'b1110;

always @(*) begin
    case (valor_i)
                              
                            //g,f,e,d,c,b,a,dp.
        4'h0: segmentos_o = 8'b00000011;            // Hexadecimal 0
        4'h1: segmentos_o = 8'b10011111;            // Hexadecimal 1
        4'h2: segmentos_o = 8'b00100101;            // Hexadecimal 2
        4'h3: segmentos_o = 8'b00001101;            // Hexadecimal 3
        4'h4: segmentos_o = 8'b10011001;            // Hexadecimal 4
        4'h5: segmentos_o = 8'b01001001;            // Hexadecimal 5
        4'h6: segmentos_o = 8'b01000001;            // Hexadecimal 6
        4'h7: segmentos_o = 8'b00011111;            // Hexadecimal 7
        4'h8: segmentos_o = 8'b00000001;            // Hexadecimal 8
        4'h9: segmentos_o = 8'b00001001;            // Hexadecimal 9
        4'hA: segmentos_o = 8'b00010001;            // Hexadecimal A
        4'hB: segmentos_o = 8'b11000001;            // Hexadecimal B
        4'hC: segmentos_o = 8'b01100011;            // Hexadecimal C
        4'hD: segmentos_o = 8'b10000101;            // Hexadecimal D
        4'hE: segmentos_o = 8'b01100001;            // Hexadecimal E
        4'hF: segmentos_o = 8'b01110001;            // Hexadecimal F
        
    endcase
end

endmodule
// ****************************************************************************
// EOF
// ****************************************************************************