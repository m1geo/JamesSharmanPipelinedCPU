/*

Name:				Constant Register V2
Schematic Source:   https://easyeda.com/weirdboyjim/constantregisterv1_copy
Schematic Rev:		2.0 (2019-01-13)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
	Just an empty module with ports.
	
*/

module ConstantRegisterV2 (
	inout	[7:0] 	MainBus,
	inout	[7:0]	MemData,
	input			a_main_n,	// active low
	input			load_n		// active low
);

	// main code goes here!

endmodule