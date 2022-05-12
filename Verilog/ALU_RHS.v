/*

Name:				ALU RHS Bitwise Logic
Schematic Source:   https://easyeda.com/weirdboyjim/alu-rhs
Schematic Rev:		1.0 (2020-11-25)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
	Just an empty module with ports.
	Video1:		https://youtu.be/pMV_0qT0uY0 (design of logic)
	Video2:		https://www.youtube.com/watch?v=3k-Batj7t-0 (design of PCB + register)
	
*/

module ALU_RHS (
	input 			AluClock,
	input	[7:0] 	LHS,
	input	[7:0] 	RHS,
	output	[7:0]	Logic,
	
	// RHS Control
	input			AC0_RHS0,
	input			AC1_RHS1,
	input			AC2_RHS2,
	input			AC3_RHS3
);

	// main code goes here!

endmodule
