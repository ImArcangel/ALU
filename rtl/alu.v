`timescale 1ns / 1ps
/*
 ******************************************************************************
 * Grupo: 07
 * C1: 13-10936 Rafael Moreno
 * C2: 14-10079 Amanda Barrios
 * C3: 15-10242 Daniela Carfora
 * Módulo: ALU de 4-bits
 ******************************************************************************
 */
module alu(
    input [3:0]      a_i,      // Entrada A
    input [3:0]      b_i,      // Entrada B
    input [3:0]      op_i,     // Operación
    output reg [3:0] result_o, // Salida de la operación
    output reg       invalid   // Salida para operación invalida
    );

	


always @(*) begin
    case (op_i)
                              
                            
        	4'h0: begin invalid = 1'h0; result_o = (a_i + b_i); end// Suma
       		4'h1: begin invalid = 1'h0; result_o = (a_i - b_i); end// Resta
		4'h2: begin invalid = 1'h0; result_o = (a_i & b_i); end// AND
		4'h3: begin invalid = 1'h0; result_o = (a_i | b_i); end// OR
		4'h4: begin invalid = 1'h0; result_o = (a_i ^ b_i); end// XOR
		4'h5: begin invalid = 1'h0; result_o = a_i; end   // A (Asigna a la salida el valor del puerto A)
		4'h6: begin invalid = 1'h0; result_o = b_i; end   // B (Asigna a la salida el valor del puerto B)
		4'h7: begin invalid = 1'h0; result_o = -(a_i); end  // -A
		4'h8: begin invalid = 1'h0; result_o = -(b_i); end  // -B
		4'h9: begin invalid = 1'h0; result_o = ~(a_i); end// ~A (Negar bit a bit)
		4'hA: begin invalid = 1'h0; result_o = ~(b_i); end// ~B (Negar bit a bit)
        default: begin invalid = 1'h1; result_o = 4'h0; end // Inválido, salida 0.
		
    endcase
end


endmodule
// ****************************************************************************
// EOF
// ****************************************************************************
