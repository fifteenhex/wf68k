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

WF68K10_WORK=wf68k10
WF68K10_FILE=wf68k10_address_registers.vhd \
		wf68k10_bus_interface.vhd \
		wf68k10_data_registers.vhd \
		wf68k10_opcode_decoder.vhd \
		wf68k10_top.vhd \
		wf68k10_alu.vhd \
		wf68k10_control.vhd \
		wf68k10_exception_handler.vhd \
		wf68k10_pkg.vhd

WF68K30L_WORK=wf68k30L
WF68K30L_FILES= wf68k30L/wf68k30L_address_registers.vhd \
		wf68k30L/wf68k30L_bus_interface.vhd \
		wf68k30L/wf68k30L_data_registers.vhd \
		wf68k30L/wf68k30L_opcode_decoder.vhd  \
		wf68k30L/wf68k30L_top.vhd \
		wf68k30L/wf68k30L_alu.vhd \
		wf68k30L/wf68k30L_control.vhd \
		wf68k30L/wf68k30L_exception_handler.vhd \
		wf68k30L/wf68k30L_pkg.vhd

wf68k30L.v:
	rm -rf $@.build
	mkdir $@.build
	ghdl -i $(GHDL_ARGS) --work=$(WF68K30L_WORK) --workdir=$@.build -Pbuild $(WF68K30L_FILES)
	ghdl -m $(GHDL_ARGS) --work=$(WF68K30L_WORK) --workdir=$@.build WF68K30L_TOP
	ghdl synth $(GHDL_ARGS) --work=$(WF68K30L_WORK) --workdir=$@.build -Pbuild \
	--out=verilog WF68K30L_TOP > $@
