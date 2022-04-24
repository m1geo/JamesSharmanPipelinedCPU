/*

Name:				ALU Control
Schematic Source:   https://easyeda.com/weirdboyjim/alu-control
Schematic Rev:		1.0 (2020-11-25)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
	Just an empty module with ports.
	
*/

module ALU_Control (
	input			Clock

	// ALU IO
	output 			AluClock,
	output			AluActive,
	
	// ALU Control
	output			AC0_RHS0,
	output			AC1_RHS1,
	output			AC2_RHS2,
	output			AC3_RHS3
	output			AC4_LHS0,
	output			AC5_LHS1,
	output			AC6_CS0,
	output			AC7_CS1,
	
	// ALU OP
	input			Pipe1Out_4_ALUOP0,
	input			Pipe1Out_5_ALUOP1,
	input			Pipe1Out_6_ALUOP2,
	input			Pipe1Out_7_ALUOP3,
);

	// main code goes here!

endmodule