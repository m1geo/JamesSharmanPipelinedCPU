/*

Name:				Main Pipeline

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
	This module joins the pipeline stages together
*/

// Include Submodules.
`include "Pipeline0/PipelineStage0.v"
`include "Pipeline1/PipelineStage1.v"
`include "Pipeline2/PipelineStage2.v"


module Pipeline (
	input			ClockIn,
	input			BusRequest,
	input			FetchSurpress,
	input	[7:0] 	MEMDATA,
	output	[7:0]	PipeOut,
		
	// control outputs
	output	[1:0]	Pipe0Out, // 2 bits only from fetch
	output [15:0]	Pipe1Out,
	output [15:0]	Pipe2Out,
	
	// flag inputs
	input	[6:0]	Flags
);

	// Pipeline Stage 0
	wire [7:0] PipeOut0In1;
	PipelineStage0 pls0 (
		.ClockIn(ClockIn), // in
		.BusRequest(BusRequest), // in
		.FetchSurpress(FetchSurpress), // in
		.MEMDATA(MEMDATA), // in [7:0]
		.PipeOut(PipeOut0In1), // out [7:0]
		
		// flag inputs (all single bit inputs)
		.Flags_5_PCRA_Flip(Flags[5]), // in
		
		// control outputs (all single bit outputs)
		.Pipe0Out_0_IncPCRA0(Pipe0Out[0]), // out
		.Pipe0Out_1_IncPCRA1(Pipe0Out[1]) // out
	);
	
	// Pipeline Stage 1
	wire [7:0] PipeOut1In2;
	PipelineStage1 pls1 (
		.ClockIn(ClockIn), // in
		.BusRequest(BusRequest), // in
		.PipeIn(PipeOut0In1), // in [7:0]
		.PipeOut(PipeOut1In2), // out [7:0]
	
		// flag inputs (all single bit inputs)
		.Flags_0_Overflow(Flags[0]),
		.Flags_1_Sign(Flags[1]),
		.Flags_2_Zero(Flags[2]),
		.Flags_3_CarryA(Flags[3]),
		.Flags_4_CarryL(Flags[4]),
		.Flags_5_PCRA_Flip(Flags[5]),
		.Flags_6_Reset(Flags[6]),
	
		// control outputs (all single bit outputs)
		.Pipe1Out_0_LHS0(Pipe1Out[0]),
		.Pipe1Out_1_LHS1(Pipe1Out[1]),
		.Pipe1Out_2_RHS0(Pipe1Out[2]),
		.Pipe1Out_3_RHS1(Pipe1Out[3]),
		.Pipe1Out_4_ALUOP0(Pipe1Out[4]),
		.Pipe1Out_5_ALUOP1(Pipe1Out[5]),
		.Pipe1Out_6_ALUOP2(Pipe1Out[6]),
		.Pipe1Out_7_ALUOP3(Pipe1Out[7]),
		.Pipe1Out_8_XLD0(Pipe1Out[8]),
		.Pipe1Out_9_XLD1(Pipe1Out[9]),
		.Pipe1Out_10_XLD2(Pipe1Out[10]),
		.Pipe1Out_11_XLD3(Pipe1Out[11]),
		.Pipe1Out_12_XA0(Pipe1Out[12]),
		.Pipe1Out_13_XA1(Pipe1Out[13]),
		.Pipe1Out_14_XA2(Pipe1Out[14]),
		.Pipe1Out_15_FetchSurpress(Pipe1Out[15])
	);

	// Pipeline Stage 2
	PipelineStage2 pls2 (
		.ClockIn(ClockIn), // in
		.PipeIn(PipeOut1In2), // in [7:0]
		.PipeOut(PipeOut), // out [7:0]
	
		// flag inputs (all single bit inputs)
		.Flags_0_Overflow(Flags[0]),
		.Flags_1_Sign(Flags[1]),
		.Flags_2_Zero(Flags[2]),
		.Flags_3_CarryA(Flags[3]),
		.Flags_4_CarryL(Flags[4]),
		.Flags_5_PCRA_Flip(Flags[5]),
		.Flags_6_Reset(Flags[6]),
	
		// control outputs (all single bit outputs)
		.Pipe2Out_0_MainAssert0(Pipe2Out[0]),
		.Pipe2Out_1_MainAssert1(Pipe2Out[1]),
		.Pipe2Out_2_MainAssert2(Pipe2Out[2]),
		.Pipe2Out_3_MainAssert3(Pipe2Out[3]),
		.Pipe2Out_4_MainLoad0(Pipe2Out[4]),
		.Pipe2Out_5_MainLoad1(Pipe2Out[5]),
		.Pipe2Out_6_MainLoad2(Pipe2Out[6]),
		.Pipe2Out_7_MainLoad3(Pipe2Out[7]),
		.Pipe2Out_8_Inc0(Pipe2Out[8]),
		.Pipe2Out_9_Inc1(Pipe2Out[9]),
		.Pipe2Out_10_Addr0(Pipe2Out[10]),
		.Pipe2Out_11_Addr1(Pipe2Out[11]),
		.Pipe2Out_12_Addr2(Pipe2Out[12]),
		.Pipe2Out_13_BusRequest(Pipe2Out[13]),
		.Pipe2Out_14_PCRA_Flip(Pipe2Out[14]),
		.Pipe2Out_15_Break(Pipe2Out[15])
	);
	
endmodule
