/*

Name:				ALU_Output - TESTBENCH

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-05-12)

Module notes:
    Testbench for ALU Output
*/

// unimportant timescale.
`timescale 1 ns/10 ps

module tb_ALU_Output();
localparam period = 1000; // period is 1000 nanoseconds (slow because of BUFGCE simulation delay)


reg tb_clk;
reg [7:0] tb_Shift = 0;
reg [7:0] tb_Logic = 0;
reg [1:0] tb_CS = 0;
reg tb_Alu_Assert = 1;
reg tb_LCarryNew = 0;

wire [7:0] tb_MainBus;
wire tb_Flags_0_Overflow;
wire tb_Flags_1_Sign;
wire tb_Flags_2_Zero;
wire tb_Flags_3_CarryA;
wire tb_Flags_4_CarryL;

ALU_Output DUT (
	.AluClock(tb_clk), // in
	.MainBus(tb_MainBus), // out
	.Shift(tb_Shift), // in 
	.Logic(tb_Logic), // in
	.Flags_0_Overflow(tb_Flags_0_Overflow), //out
	.Flags_1_Sign(tb_Flags_1_Sign), //out
	.Flags_2_Zero(tb_Flags_2_Zero), //out
	.Flags_3_CarryA(tb_Flags_3_CarryA), //out
	.Flags_4_CarryL(tb_Flags_4_CarryL), //out
	
	.LCARRYNEW(tb_LCarryNew), //in
	.AC6_CS0(tb_CS[0]), //in
	.AC7_CS1(tb_CS[1]), //in
	.Alu_Assert(tb_Alu_Assert) //in
);

	// generate clock
    always #(period/5) tb_clk=~tb_clk;

    initial begin
		tb_clk = 0;
		
		// Quick test
		tb_CS = 2'b0;
		tb_Alu_Assert = 1;
		tb_LCarryNew = 0;
		tb_Shift = 0;
		tb_Logic = 0;
		#period;
		tb_Shift = 5;
		tb_Logic = 5;
		#period;
		tb_Alu_Assert = 0;
		#period;
		tb_Shift = 0;
		tb_Logic = 0;
		tb_Alu_Assert = 1;
		#period;
		
		// test Carry In
		tb_Shift = 8'hFF;
		tb_Logic = 0;
		tb_Alu_Assert = 1;
		#period;
		tb_Alu_Assert = 0;
		#period;
		tb_Alu_Assert = 1;
		#period;
		tb_LCarryNew = 1;
		#period;
		tb_Alu_Assert = 0;
		#period;
		tb_Alu_Assert = 1;
		tb_LCarryNew = 0;
		#period;
		
		// test Carry Out
		tb_Shift = 8'hFF;
		tb_Logic = 1;
		tb_CS = 1; // use ACarryPrev
		tb_Alu_Assert = 1;
		#period;
		tb_Alu_Assert = 0;
		#period;
		tb_Alu_Assert = 1;
		#period;
		tb_LCarryNew = 1;
		#period;
		tb_Alu_Assert = 0;
		#period;
		tb_Alu_Assert = 1;
		tb_LCarryNew = 0;
		#period;
		
        $finish;
    end
endmodule // end testbench