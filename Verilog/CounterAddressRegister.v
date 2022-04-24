/*

Name:				Counter/Address Register V1
Schematic Source:   https://easyeda.com/weirdboyjim/8bit-CPU
Schematic Rev:		1.0 (2019-01-13)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
	Just an empty module with ports.
	
*/

module CounterAddressRegister (
	inout	[15:0] 	Addr,
	inout	[15:0]	Bus,
	inout	[7:0]	RHSBus,
	input			clock,
	input			clear,		// active high
	input			dec,		// active low
	input			inc,		// active low
	input			load_n,		// active low
	input			a_addr_n,	// active low
	input			a_bus_n		// active low
);

	// main code goes here!

endmodule