/*

Name:				Mem Bridge
Schematic Source:   https://easyeda.com/weirdboyjim/membridge
Schematic Rev:		1.0 (2020-03-08?)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
	Just an empty module with ports.
	
*/

module MemBridge (

	inout	[7:0]	MainBus,
	inout	[7:0]	MEMDATA,
	
	// Mem Inputs
	input			MemBridge_Assert,
	input			MemBridge_Direction,

);

	// main code goes here!

endmodule