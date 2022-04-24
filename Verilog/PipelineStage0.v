/*

Name:				Pipeline Stage 0
Schematic Source:   https://easyeda.com/weirdboyjim/Pipeline-Stage-0
Schematic Rev:		1.0 (2019-01-13)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
	Just an empty module with ports.
	
*/

module PipelineStage0 (
	input			ClockIn,
	input			BusRequest,
	input			FetchSurpress,
	input	[7:0] 	MEMDATA,
	output	[7:0]	PipeOut,
		
	// control outputs
	output			Pipe0Out_0_IncPCRA0,
	output			Pipe0Out_1_IncPCRA1,
	
	// flag inputs
	input			Flags_5_PCRA_Flip,
);

	// main code goes here!

endmodule