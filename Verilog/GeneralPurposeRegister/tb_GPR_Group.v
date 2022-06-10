/*

Name:				GPR Group - TESTBENCH

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-06-11)

Module notes:
    Testbench for Group of V1 general purpose registers
    
*/

// unimportant timescale.
`timescale 10 ns/1 ns

module tb_GPR_Group;

wire [7:0] tb_MainBus;
wire [7:0] tb_LHSBus;
wire [7:0] tb_RHSBus;

reg  [7:0] tb_MainBus_val; // tristate workaround
reg        tb_MainBus_dir = 0; // tristate workaround
assign tb_MainBus = tb_MainBus_dir ? tb_MainBus_val : 8'bZ;

reg        tb_a_load = 1;
reg        tb_b_load = 1;
reg        tb_c_load = 1;
reg        tb_d_load = 1;

reg        tb_a_main_assert = 1;
reg        tb_b_main_assert = 1;
reg        tb_c_main_assert = 1;
reg        tb_d_main_assert = 1;

reg        tb_a_lhs_assert = 1;
reg        tb_b_lhs_assert = 1;
reg        tb_c_lhs_assert = 1;
reg        tb_d_lhs_assert = 1;

reg        tb_a_rhs_assert = 1;
reg        tb_b_rhs_assert = 1;
reg        tb_c_rhs_assert = 1;
reg        tb_d_rhs_assert = 1;

localparam period = 10; // period is 10 nanoseconds

GPR_Group DUT (
	.MainBus(tb_MainBus),
	.LHSBus(tb_LHSBus),
	.RHSBus(tb_RHSBus),

	// GPR A
	.a_load(tb_a_load),
	.a_main_assert(tb_a_main_assert),
	.a_lhs_assert(tb_a_lhs_assert),
	.a_rhs_assert(tb_a_rhs_assert),
	
	// GPR B
	.b_load(tb_b_load),
	.b_main_assert(tb_b_main_assert),
	.b_lhs_assert(tb_b_lhs_assert),
	.b_rhs_assert(tb_b_rhs_assert),
	
	// GPR C
	.c_load(tb_c_load),
	.c_main_assert(tb_c_main_assert),
	.c_lhs_assert(tb_c_lhs_assert),
	.c_rhs_assert(tb_c_rhs_assert),
	
	// GPR D
	.d_load(tb_d_load),
	.d_main_assert(tb_d_main_assert),
	.d_lhs_assert(tb_d_lhs_assert),
	.d_rhs_assert(tb_d_rhs_assert)
);

    integer i;
    
    initial begin
		for (i=0; i<16; i=i+1) begin
		    tb_MainBus_dir = (i[1:0]==2'b0); // assert onto bus when loads are enabled
		    tb_MainBus_val = tb_MainBus_dir ? $random : 8'bX; // makes simulation clearer to see
		    { tb_d_rhs_assert, tb_d_lhs_assert, tb_d_main_assert, tb_d_load,
		      tb_c_rhs_assert, tb_c_lhs_assert, tb_c_main_assert, tb_c_load,
		      tb_b_rhs_assert, tb_b_lhs_assert, tb_b_main_assert, tb_b_load,
		      tb_a_rhs_assert, tb_a_lhs_assert, tb_a_main_assert, tb_a_load } = ~(1<<i); // one cold
			#(period);
		end

        $finish;
    end
endmodule // end testbench