#!/usr/bin/env python3

import os
import myhdl as hdl

# Constantes
TIMEOUT = 70000
TICK_PERIOD = 10


@hdl.block
def alu_testbench():
    """
    Ejecutar la cosimulación usando Icarus Verilog.
    """
    A       = hdl.Signal(hdl.modbv(0, _nrbits=4))
    B       = hdl.Signal(hdl.modbv(0, _nrbits=4))
    OP      = hdl.Signal(hdl.modbv(0, _nrbits=4))
    result  = hdl.Signal(hdl.modbv(0, _nrbits=4))
    invalid = hdl.Signal(hdl.modbv(False))
    cmd1    = 'iverilog -o out/alu.o rtl/alu.v test/tb_alu.v'
    cmd2    = 'vvp -v -m myhdl out/alu.o'

    def alu_compilation(A, B, OP, result, invalid):
        """
        Función 'local' auxiliar.
        """
        os.system(cmd1)
        return hdl.Cosimulation(cmd2,
                                A=A,
                                B=B,
                                OP=OP,
                                result=result,
                                invalid=invalid)

    @hdl.instance
    def generate_inputs():
        for a in range(16):
            for b in range(16):
                # Asignar valores a los puertos de entrada
                A.next  = a
                B.next  = b

                for op in range(16):
                    OP.next = op  # asignar operación
                    yield hdl.delay(1)  # esperar una unidad de tiempo para que ejecute el simulador. fs

                    if op == 0:
                        assert result == hdl.modbv(A + B)[4:], "Error ADD. A = {0}, B = {1}".format(hex(A), hex(B))
                    elif op == 1:
                        assert result == hdl.modbv(A - B)[4:], "Error SUB. A = {0}, B = {1}".format(hex(A), hex(B))
                    elif op == 2:
                        assert result == A & B, "Error AND. A = {0}, B = {1}".format(hex(A), hex(B))
                    elif op == 3:
                        assert result == A | B, "Error OR. A = {0}, B = {1}".format(hex(A), hex(B))
                    elif op == 4:
                        assert result == A ^ B, "Error XOR. A = {0}, B = {1}".format(hex(A), hex(B))
                    elif op == 5:
                        assert result == A, "Error A"
                    elif op == 6:
                        assert result == B, "Error B"
                    elif op == 7:
                        assert result == hdl.modbv(-A)[4:], "Error -A"
                    elif op == 8:
                        assert result == hdl.modbv(-B)[4:], "Error -B"
                    elif op == 9:
                        assert result == ~A, "Error ~A"
                    elif op == 10:
                        assert result == ~B, "Error ~B"
                    else:
                        assert result == 0, "Error UNDEFINED OP: salida no es 0."
                        assert invalid, "Error UNDEFINED OP: invalid output no detectada."
        raise hdl.StopSimulation

    @hdl.instance
    def timeout():
        yield hdl.delay(TIMEOUT * TICK_PERIOD)
        raise hdl.Error("Test failed: TIMEOUT")

    return hdl.instances(), alu_compilation(A, B, OP, result, invalid)


def test_alu():
    """
    Función dummy para que pytest encuentre el test en forma automática.
    """
    tb = alu_testbench()
    tb.run_sim()
