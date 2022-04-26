/*

Name:				General Purpose Register V1 - TESTBENCH

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-04-26)

Module notes:
    Testbench for V2 general purpose register 
    
*/

// unimportant timescale.
`timescale 1 ns/10 ps

module tb_GeneralPurposeRegister;
localparam period = 10; // period is 10 nanoseconds

reg        tb_d_membridge_n;
reg        tb_a_membridge_n;

wire [7:0] tb_MainBus;
reg  [7:0] tb_MainBus_val;
reg        tb_MainBus_dir;
assign tb_MainBus = tb_MainBus_dir ? tb_MainBus_val : 8'bZ;

wire [7:0] tb_MemData;
reg  [7:0] tb_MemData_val;
reg        tb_MemData_dir;
assign tb_MemData = tb_MemData_dir ? tb_MemData_val : 8'bZ;

MemBridge DUT (
	.MainBus(tb_MainBus),
	.MemData(tb_MemData),
	
	.a_membridge_n(tb_a_membridge_n),	// active low, MemData->MainBus
	.d_membridge_n(tb_d_membridge_n)	// active low, MainBus->MemData
);
    
    initial
    begin
        tb_MainBus_val   = 8'hAA;
        tb_MainBus_dir   = 1;
        tb_MemData_val   = 8'h0;
        tb_MemData_dir   = 0;
        tb_a_membridge_n = 1;
        tb_d_membridge_n = 1;
        #period; // wait
        
        tb_MainBus_val   = 8'h0;
        tb_MainBus_dir   = 0;
        tb_MemData_val   = 8'h55;
        tb_MemData_dir   = 1;
        tb_a_membridge_n = 1;
        tb_d_membridge_n = 1;
        #period; // wait
        
        tb_MainBus_val   = 8'h0;
        tb_MainBus_dir   = 0;
        tb_MemData_val   = 8'h0;
        tb_MemData_dir   = 0;
        tb_a_membridge_n = 1;
        tb_d_membridge_n = 1;
        #period; // wait
        
        tb_MainBus_val   = 8'h55;
        tb_MainBus_dir   = 1;
        tb_MemData_val   = 8'hAA;
        tb_MemData_dir   = 1;
        tb_a_membridge_n = 1;
        tb_d_membridge_n = 1;
        #period; // wait

        tb_MainBus_val   = 8'h0;
        tb_MainBus_dir   = 0;
        tb_MemData_val   = 8'h0;
        tb_MemData_dir   = 0;
        tb_a_membridge_n = 1;
        tb_d_membridge_n = 1;
        #period; // wait

        tb_MainBus_val   = 8'hAA;
        tb_MainBus_dir   = 1;
        tb_MemData_val   = 8'h0;
        tb_MemData_dir   = 0;
        tb_a_membridge_n = 1;
        tb_d_membridge_n = 0;
        #period; // wait
        
        tb_MainBus_val   = 8'h0;
        tb_MainBus_dir   = 0;
        tb_MemData_val   = 8'h0;
        tb_MemData_dir   = 0;
        tb_a_membridge_n = 1;
        tb_d_membridge_n = 1;
        #period; // wait
        
        tb_MainBus_val   = 8'h0;
        tb_MainBus_dir   = 0;
        tb_MemData_val   = 8'h55;
        tb_MemData_dir   = 1;
        tb_a_membridge_n = 0;
        tb_d_membridge_n = 1;
        #period; // wait
        
        tb_MainBus_val   = 8'h0;
        tb_MainBus_dir   = 0;
        tb_MemData_val   = 8'h0;
        tb_MemData_dir   = 0;
        tb_a_membridge_n = 1;
        tb_d_membridge_n = 1;
        #period; // wait

        $finish;
    end
endmodule // end testbench