/*

Name:				MainMemory64Shadow
Schematic Source:   https://easyeda.com/weirdboyjim/MainMemory3232_copy
Schematic Rev:		2.0 (2020-03-08)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
	Just an empty module with ports.
	See also MainMemory3232 which has a 32k RAM & 32k ROM space.
	
*/

module MainMemory64Shadow (
	input	CopyClock,

	inout	[15:0] 	Addr,
	inout	[7:0]	MEMDATA,
	
	// Mem Inputs
	input			MemBridge_Load,
	input			MemBridge_Direction,
	input			Memory_Ack,
	input			ResetReq
);

	// main code goes here!

endmodule