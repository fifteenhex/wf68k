module main;

  reg clk;
  reg nreset;
  reg nberr;
  reg navec;
  reg [2:0] nipl;
  reg ndtack;
  reg nvpa;
  reg nbr;
  reg nbgack;
  tri1 nhalt;
  tri0 [15:0] data;

/*
input  CLK,
   input  RESET_COREn,
   input  BERRn,
   input  AVECn,
   input  [2:0] IPLn,
   input  DTACKn,
   input  VPAn,
   input  BRn,
   input  BGACKn,
   output [22:0] ADR,
   inout  [15:0] DATA,
   inout  RESETn,
   inout  HALTn,
   output [2:0] FC,
   output ASn,
   output RWn,
   output UDSn,
   output LDSn,
   output E,
   output VMAn,
   output BGn
   */

WF68K00IP_TOP cpu (
	.CLK(clk),
	.RESET_COREn(nreset),
	.BERRn(nberr),
	.AVECn(navec),
	.IPLn(nipl),
	.DTACKn(ndtack),
	.VPAn(nvpa),
	.BRn(nbr),
	.BGACKn(nbgack),
	.DATA(data),
	.HALTn(nhalt)
);

  always #10 clk = ~clk;

  initial begin
  	 $dumpfile("wf68k00.vcd");
  	 $dumpvars(0,cpu);

     clk = 0;
     nreset = 0;
     nberr = 1;
     navec = 0;
     nipl = 3'b111;
     ndtack = 0;
     nvpa = 0;
     nbr = 1;
     nbgack = 1;

     #35 nreset = 1;


	#10000 nreset = 0;

     $finish;
  end

endmodule
