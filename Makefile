SHELL=bash

.FOUT=out
.PYTHON=python3
.PYTEST=pytest

.RTL_FOLDER=rtl
.TEST_FOLDER=test

.PHONY: default clean distclean

check_driver:
	@verilator --lint-only $(.RTL_FOLDER)/driver7seg.v && echo "CHECK: OK"

check_alu:
	@verilator --lint-only $(.RTL_FOLDER)/alu.v && echo "CHECK: OK"

check_tope:
	@verilator --lint-only rtl/tope.v rtl/driver7seg.v rtl/alu.v && echo "CHECK: OK"

test_alu: check_alu
	@mkdir -p $(.FOUT)/
	@$(.PYTEST) --tb=short test/test_alu.py

clean:
	@rm -rf $(.FOUT)/
	@find . | grep -E "(\.vcd)" | xargs rm -rf

distclean: clean
	@find . | grep -E "(__pycache__|\.pyc|\.pyo|\.vcd|\.cache)" | xargs rm -rf
