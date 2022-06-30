/*

Name:				CPU - TESTBENCH

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-06-30)

Module notes:
    Testbench for CPU
*/

// unimportant timescale.
`timescale 100 ns/10 ns

module tb_CPU();
localparam period = 10; // period is 1 microseconds

reg       tb_clk;
reg       tb_rst;

CPU DUT (
	.MAINCLK(tb_clk),
	.MAINRST(tb_rst)
);

	// generate clock
    always #(period) tb_clk=~tb_clk;

    integer i;

    initial begin
        tb_clk = 0;
		tb_rst = 0;
		#100;
		tb_rst = 1; // run
		#100000;
		
        $finish;
    end
endmodule // end testbench
