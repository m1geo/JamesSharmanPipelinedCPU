/*

Name:				ALU LHS Shift
Schematic Source:   https://easyeda.com/weirdboyjim/alu-lhs
Schematic Rev:		1.0 (2020-11-25)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
	Just an empty module with ports.
	
*/

module ALU_LHS (
	input 			AluClock,
	input	[7:0] 	LHS,
	output	[7:0]	Shift,
	
	// LHS Control
	input			AC4_LHS0,
	input			AC5_LHS1,
	input			LCarryIn,
	input			LCarryOut
);

	// main code goes here!

endmodule