/*

Name:				Pipeline Stage 2 - TESTBENCH

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-05-20)

Module notes:
    Testbench for Pipeline Stage 2
    ROM generation code is available from James. bin2mem.py will convert to memory files for Verilog. 
    First half of simulation, reset is asserted.
*/

// unimportant timescale.
`timescale 1 ns/10 ps

module tb_PipelineAll;
localparam period = 10; // period is 10 nanoseconds

reg       tb_clk;
reg [7:0] tb_PipeIn;
reg [6:0] tb_Flags;

//integer i;

wire [7:0] tb_PipeOut; // end of pipeline bus
wire [1:0] tb_Pipe0Out;
wire [15:0] tb_Pipe1Out;
wire [15:0] tb_Pipe2Out;

Pipeline DUT (
	.ClockIn(tb_clk), // in
	.MEMDATA(tb_PipeIn), // in
	.PipeOut(tb_PipeOut), // out
		
	// control outputs
	.Pipe0Out(tb_Pipe0Out),
	.Pipe1Out(tb_Pipe1Out),
	.Pipe2Out(tb_Pipe2Out),
	
	// flag inputs
	.Flags(tb_Flags)
);

	// generate clock
    always #(period/2) tb_clk=~tb_clk;

    initial begin
		// inital values
		tb_clk = 0;
		#(4*period/5);
		
		// walk through all combinations Flags [6:0].
		for (i=0; i<128; i=i+1) begin // 7 bits
			tb_PipeIn = $random; // random byte (gets chopped by assignment)
			tb_Flags = i[6:0];
			#(period);
		end

        $finish;
    end
endmodule // end testbench