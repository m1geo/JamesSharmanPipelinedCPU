/*

Name:				General Purpose Register V1
Schematic Source:   https://easyeda.com/weirdboyjim/general-purpose-register
Schematic Rev:		1.0 (2019-01-13)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
	Just an empty module with ports.
	
*/

module ConstantRegisterV2 (
	inout	[7:0] 	MainBus,
	inout	[7:0]	LHSBus,
	inout	[7:0]	RHSBus,
	input			a_main_n,	// active low
	input			load_n,		// active low
	input			a_lhs_n,	// active low
	input			a_lhs_n		// active low
);

	// main code goes here!

endmodule