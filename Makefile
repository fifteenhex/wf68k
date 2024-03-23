GHDL_ARGS=--std=08 -fsynopsys

WF68K00_WORK=wf68k00
WF68K00_FILES=wf68k00/wf68k00ip_address_registers.vhd \
		wf68k00/wf68k00ip_bus_interface.vhd \
		wf68k00/wf68k00ip_data_registers.vhd \
		wf68k00/wf68k00ip_opcode_decoder.vhd \
		wf68k00/wf68k00ip_shifter.vhd \
		wf68k00/wf68k00ip_top.vhd \
		wf68k00/wf68k00ip_alu.vhd \
		wf68k00/wf68k00ip_control.vhd \
		wf68k00/wf68k00ip_interrupt_controller.vhd \
		wf68k00/wf68k00ip_pkg.vhd \
		wf68k00/wf68k00ip_top_soc.vhd

wf68k00.v: $(WF68K00_FILES)
	rm -rf $@.build
	mkdir $@.build
	ghdl -i $(GHDL_ARGS) --work=$(WF68K00_WORK) --workdir=$@.build -Pbuild $(WF68K00_FILES)
	ghdl -m $(GHDL_ARGS) --work=$(WF68K00_WORK) --workdir=$@.build WF68K00IP_TOP
	ghdl synth $(GHDL_ARGS) --work=$(WF68K00_WORK) --workdir=$@.build -Pbuild \
	--out=verilog WF68K00IP_TOP > $@

wf68k00.vvp: wf68k00_test.v wf68k00.v
	iverilog -g2005-sv -o $@ $^
	
.PHONY: wf68k00_test
wf68k00_test: wf68k00.vvp
	./wf68k00.vvp

