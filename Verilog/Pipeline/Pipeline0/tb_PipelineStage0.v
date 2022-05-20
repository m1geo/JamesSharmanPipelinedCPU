/*

Name:				Pipeline Stage 0 - TESTBENCH

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-05-20)

Module notes:
    Testbench for Pipeline Stage 0
    Slight jitter added to the delay in the forloop shows what happens with the latching better, as then clock/data don't line up perfectly. 
*/

// unimportant timescale.
`timescale 1 ns/10 ps

module tb_PipelineStage0;
localparam period = 10; // period is 10 nanoseconds

reg       tb_clk;
reg [7:0] tb_MEMDATA;
reg       tb_FetchSurpress;
reg       tb_BusRequest;
reg       tb_Flags_5_PCRA_Flip;
integer i;

wire [7:0] tb_PipeOut;
wire       tb_Pipe0Out_0_IncPCRA0;
wire       tb_Pipe0Out_1_IncPCRA1;


PipelineStage0 DUT (
	.ClockIn(tb_clk), // in
	.BusRequest(tb_BusRequest), // in
	.FetchSurpress(tb_FetchSurpress), // in
	.MEMDATA(tb_MEMDATA), // in [7:0]
	.PipeOut(tb_PipeOut), // out [7:0]
		
	// control outputs
	.Pipe0Out_0_IncPCRA0(tb_Pipe0Out_0_IncPCRA0), // out
	.Pipe0Out_1_IncPCRA1(tb_Pipe0Out_1_IncPCRA1), // out
	
	// flag inputs
	.Flags_5_PCRA_Flip(tb_Flags_5_PCRA_Flip) // in
);

	// generate clock
    always #(period/2) tb_clk=~tb_clk;

    initial begin
		// inital values
		tb_clk = 0;
		
		// walk through all combinations of BusRequest, FetchSurpress, and PCRA_Flip.
		for (i=0; i<8; i=i+1) begin // 3 bits
			tb_MEMDATA = $random; // random byte (gets chopped by assignment)
			tb_BusRequest = i[0];
			tb_FetchSurpress = i[1];
			tb_Flags_5_PCRA_Flip = i[2];
			$display("BR:%u, FS:%u, FL:%u", tb_BusRequest, tb_FetchSurpress, tb_Flags_5_PCRA_Flip);
			#(period+($random%2)); // a bit of jitter, which makes the simulation not align perfectly.
		end

        $finish;
    end
endmodule // end testbench