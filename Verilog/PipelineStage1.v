/*

Name:				Pipeline Stage 1
Schematic Source:   https://easyeda.com/weirdboyjim/Pipeline-Stage-1
Schematic Rev:		1.0 (2019-01-13)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
	Just an empty module with ports.
	
*/

module PipelineStage1 (
	input			ClockIn,
	input			BusRequest,
	input	[7:0] 	PipeIn,
	output	[7:0]	PipeOut,
	
	// control outputs
	output			Pipe1Out_0_LHS0,
	output			Pipe1Out_1_LHS1,
	output			Pipe1Out_2_RHS0,
	output			Pipe1Out_3_RHS1,
	output			Pipe1Out_4_ALUOP0,
	output			Pipe1Out_5_ALUOP1,
	output			Pipe1Out_6_ALUOP2,
	output			Pipe1Out_7_ALUOP3,
	output			Pipe1Out_8_XLD0,
	output			Pipe1Out_9_XLD1,
	output			Pipe1Out_10_XLD2,
	output			Pipe1Out_11_XLD3,
	output			Pipe1Out_12_XA0,
	output			Pipe1Out_13_XA1,
	output			Pipe1Out_14_XA2,
	output			Pipe1Out_15_FetchSurpress,
	
	// flag inputs
	input			Flags_0_Overflow,
	input			Flags_1_Sign,
	input			Flags_2_Zero,
	input			Flags_3_CarryA,
	input			Flags_4_CarryL,
	input			Flags_5_PCRA_Flip,
	input			Flags_6_Reset
);

	// main code goes here!

endmodule