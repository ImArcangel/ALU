`timescale 1ns / 1ps
/*
 ******************************************************************************
 * Autor: Ángel Terrones <aterrones@usb.ve>
 * Módulo: ALU + driver7seg
 ******************************************************************************
 */
module tope(
    input [3:0]  a_i,
    input [3:0]  b_i,
    input [3:0]  op_i,
    output [7:0] segmentos_o,
    output [3:0] anodos_o,
    output       invalid_o,
    output [3:0] op_led_o
    );

wire [3:0] result;
assign op_led_o = op_i;

alu alu(
    .a_i(a_i),
    .b_i(b_i),
    .op_i(op_i),
    .result_o(result),
    .invalid(invalid_o)
    );

driver driver7seg(
    .valor_i(result),
    .anodos_o(anodos_o),
    .segmentos_o(segmentos_o)
    );

endmodule
// ****************************************************************************
// EOF
// ****************************************************************************