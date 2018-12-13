/**
 * Autor: Ángel Terrones <aterrones@usb.ve>
 *
 * Archivo puente entre el módulo a probar (ALU) y el generador de entradas
 * (test_alu.py).
 */
module dut_alu;

reg [3:0]  A;
reg [3:0]  B;
reg [3:0]  OP;
wire [3:0] result;
wire       invalid;

initial begin
    $from_myhdl(A, B, OP);      // Señales desde MYHDL (inputs)
    $to_myhdl(result, invalid); // Señales hacia MYHDL (salidas)
end

// instancia del circuito
alu dut(
    .a_i(A),
    .b_i(B),
    .op_i(OP),
    .result_o(result),
    .invalid(invalid)
    );

endmodule
// ****************************************************************************
// EOF
// ****************************************************************************
