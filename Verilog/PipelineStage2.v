/*

Name:				Pipeline Stage 2
Schematic Source:   https://easyeda.com/weirdboyjim/pipeline-stage-2
Schematic Rev:		1.0 (2019-01-13)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
	Just an empty module with ports.
	
*/

module PipelineStage2 (
	input			ClockIn,
	input	[7:0] 	PipeIn,
	output	[7:0]	PipeOut,
	
	// control outputs
	output			Pipe2Out_0_MainAssert0,
	output			Pipe2Out_1_MainAssert1,
	output			Pipe2Out_2_MainAssert2,
	output			Pipe2Out_3_MainAssert3,
	output			Pipe2Out_4_MainLoad0,
	output			Pipe2Out_5_MainLoad1,
	output			Pipe2Out_6_MainLoad2,
	output			Pipe2Out_7_MainLoad3,
	output			Pipe2Out_8_Inc0,
	output			Pipe2Out_9_Inc1,
	output			Pipe2Out_10_Addr0,
	output			Pipe2Out_11_Addr1,
	output			Pipe2Out_12_Addr2,
	output			Pipe2Out_13_BusRequest,
	output			Pipe2Out_14_PCRA_Flip,
	output			Pipe2Out_15_Break,
	
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