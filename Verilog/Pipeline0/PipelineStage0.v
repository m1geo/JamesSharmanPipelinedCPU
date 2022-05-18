/*

Name:				Pipeline Stage 0 (Fetch)
Schematic Source:   https://easyeda.com/weirdboyjim/Pipeline-Stage-0
Schematic Rev:		1.0 (2019-01-13)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
	Video: https://www.youtube.com/watch?v=GkUddJNc24c
	Just a simple latch to hold the pipe data, and a mux to chose current or latched data
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
	input			Flags_5_PCRA_Flip
);

	reg [7:0] PipeLatch;
	
	always @ (posedge ClockIn) begin
		PipeLatch <= MEMDATA;
	end
	
	// MUXes to select state output
	assign PipeOut = FetchSurpress ? (BusRequest ? PipeLatch : 8'b0') : (BusRequest ? 8'b0 : MEMDATA);
	
	assign Pipe0Out_0_IncPCRA0 = Flags_5_PCRA_Flip;
	assign Pipe0Out_1_IncPCRA1 = BusRequest;

endmodule
