/*

Name:				ALU_LHS - TESTBENCH

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-05-13)

Module notes:
    Testbench for ALU LHS
*/

// unimportant timescale.
`timescale 1 ns/10 ps

module tb_ALU_LHS();
localparam period = 10; // period is 10 nanoseconds
localparam clkstep = 1; // clocktick is 1 nanosecond

reg [7:0] tb_LHS = 0;
reg tb_clk;
reg tb_AC4_LHS0;
reg tb_AC5_LHS1;
reg tb_LCarryIn;

wire [7:0] tb_Shift;
wire tb_LCarryOut;

ALU_LHS DUT (
	.AluClock(tb_clk),
	.LHS(tb_LHS),
	.Shift(tb_Shift), // out

	.AC4_LHS0(tb_AC4_LHS0),
	.AC5_LHS1(tb_AC5_LHS1),
	.LCarryIn(tb_LCarryIn),
	.LCarryOut(tb_LCarryOut) // out
);

    always #clkstep tb_clk = !tb_clk;

    initial begin
        // init clock
        tb_clk = 0;


		// Unchanged
		tb_LHS      = 8'b00001000;
		tb_LCarryIn = 0;
		tb_AC4_LHS0 = 0;
		tb_AC5_LHS1 = 0;
		#period

		tb_LHS      = 8'b00001000;
		tb_LCarryIn = 1;
		tb_AC4_LHS0 = 0;
		tb_AC5_LHS1 = 0;
		#period


		// Shift Left
		tb_LHS      = 8'b00001000;
		tb_LCarryIn = 0;
		tb_AC4_LHS0 = 1;
		tb_AC5_LHS1 = 0;
		#period

		tb_LHS      = 8'b00001000;
		tb_LCarryIn = 1;
		tb_AC4_LHS0 = 1;
		tb_AC5_LHS1 = 0;
		#period


		// Shift Right
		tb_LHS      = 8'b00001000;
		tb_LCarryIn = 0;
		tb_AC4_LHS0 = 0;
		tb_AC5_LHS1 = 1;
		#period

		tb_LHS      = 8'b00001000;
		tb_LCarryIn = 1;
		tb_AC4_LHS0 = 0;
		tb_AC5_LHS1 = 1;
		#period


		// Zero
		tb_LHS      = 8'b00001000;
		tb_LCarryIn = 0;
		tb_AC4_LHS0 = 1;
		tb_AC5_LHS1 = 1;
		#period

		tb_LHS      = 8'b00001000;
		tb_LCarryIn = 1;
		tb_AC4_LHS0 = 1;
		tb_AC5_LHS1 = 1;
		#period


		// Shift Left + carry overflow
		tb_LHS      = 8'b10000001;
		tb_LCarryIn = 0;
		tb_AC4_LHS0 = 1;
		tb_AC5_LHS1 = 0;
		#period		


		// Shift Right + carry overflow
		tb_LHS      = 8'b10000001;
		tb_LCarryIn = 0;
		tb_AC4_LHS0 = 0;
		tb_AC5_LHS1 = 1;
		#period

        $finish;
    end
endmodule // end testbench