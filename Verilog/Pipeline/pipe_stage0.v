// -----------------------------------------------------------------------------
// Title   : Pipeline Stage 0 (Pipeline/pipe_stage0.v)
// Create  : Tue 20 Dec 22:32:25 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : Pipeline Stage 0
//         : Original schematic: https://oshwlab.com/weirdboyjim/pipeline-stage-0
// -----------------------------------------------------------------------------

module pipe_stage0
(
    input        clk,
    input  [7:0] MemData,
    input        BusRequest,
    input        FetchSuppress,
    input        Flag5_PCRA_Flip,
    
    output [7:0] Pipe0Out,
    output       Pipe0Out0_IncPCRA0,
    output       Pipe0Out1_IncPCRA1
);

    // Latch the MemData Word
	reg [7:0] PipeLatch;
	
	// update PipeLatch on clk posedge
	always @ (posedge clk) begin
		PipeLatch <= MemData;
	end
	
	// In schematic, Pipe0Out is driven by 4:1 MUXes 74HCT153 (IC10-IC13).
	assign Pipe0Out = FetchSuppress ? (BusRequest ? PipeLatch : 8'b0) : (BusRequest ? 8'b0 : MemData);
	
	// In schematic, IncPCRA0 is driven by two inline inverters, 1 and 2 of 74HCT04(U10) from Flag5_PCRA_Flip.
	assign Pipe0Out0_IncPCRA0 = Flag5_PCRA_Flip; 
	
	// In schematic, IncPCRA1 is driven by two inline inverters, 6 and 5 of 74HCT04(U10) from BusRequest.
	assign Pipe0Out1_IncPCRA1 = BusRequest;
	
endmodule //end:pipe_stage0
