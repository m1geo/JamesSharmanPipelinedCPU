/*

Name:				General Purpose Register V1 - TESTBENCH

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-04-26)

Module notes:
    Testbench for V1 general purpose register 
    
*/

// unimportant timescale.
`timescale 1 ns/10 ps

module tb_GeneralPurposeRegister;

reg        tb_a_main_n;
reg        tb_a_lhs_n;
reg        tb_a_rhs_n;
reg        tb_load;
wire [7:0] tb_MainBus;
wire [7:0] tb_LHSBus;
wire [7:0] tb_RHSBus;

reg  [7:0] tb_MainBus_val; // tristate workaround
reg        tb_MainBus_dir; // tristate workaround
assign tb_MainBus = tb_MainBus_dir ? tb_MainBus_val : 8'bZ;

localparam period = 10; // period is 10 nanoseconds

 

GeneralPurposeRegister DUT (
	.MainBus(tb_MainBus),
	.LHSBus(tb_LHSBus),
	.RHSBus(tb_RHSBus),
	.load(tb_load),	    // active rising
	.a_main_n(tb_a_main_n),	// active low
	.a_lhs_n(tb_a_lhs_n),	// active low
	.a_rhs_n(tb_a_rhs_n)	// active low
);
    
    initial
    begin
        tb_MainBus_val = 8'h0;
        tb_MainBus_dir = 0;
        tb_a_main_n =    1;
        tb_a_lhs_n  =    1;
        tb_a_rhs_n  =    1;
        tb_load =        0;
        #period; // wait
        
        tb_MainBus_val = 8'hAA;
        tb_MainBus_dir = 1;
        tb_a_main_n =    1;
        tb_a_lhs_n  =    1;
        tb_a_rhs_n  =    1;
        tb_load =        0;
        #period; // wait
        
        tb_MainBus_val = 8'hAA;
        tb_MainBus_dir = 1;
        tb_a_main_n =    1;
        tb_a_lhs_n  =    1;
        tb_a_rhs_n  =    1;
        tb_load =        1;
        #period; // wait

        tb_MainBus_val = 8'h0;
        tb_MainBus_dir = 0;
        tb_a_main_n =    1;
        tb_a_lhs_n  =    1;
        tb_a_rhs_n  =    1;
        tb_load =        0;
        #period; // wait
        
        tb_MainBus_val = 8'h0;
        tb_MainBus_dir = 0;
        tb_a_main_n =    0;
        tb_a_lhs_n  =    1;
        tb_a_rhs_n  =    1;
        tb_load =        0;
        #period; // wait
        
        tb_MainBus_val = 8'h0;
        tb_MainBus_dir = 0;
        tb_a_main_n =    1;
        tb_a_lhs_n  =    0;
        tb_a_rhs_n  =    1;
        tb_load =        0;
        #period; // wait
        
        tb_MainBus_val = 8'h0;
        tb_MainBus_dir = 0;
        tb_a_main_n =    1;
        tb_a_lhs_n  =    1;
        tb_a_rhs_n  =    0;
        tb_load =        0;
        #period; // wait

        tb_MainBus_val = 8'h0;
        tb_MainBus_dir = 0;
        tb_a_main_n =    1;
        tb_a_lhs_n  =    1;
        tb_a_rhs_n  =    1;
        tb_load =        0;
        #period; // wait
        

        $finish;
    end
endmodule // end testbench