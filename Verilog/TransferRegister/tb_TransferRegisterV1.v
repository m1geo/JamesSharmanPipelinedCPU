/*

Name:				Transfer Register - TESTBENCH

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-04-27)

Module notes:
    Testbench for Transfer Register
    
*/

// unimportant timescale.
`timescale 1 ns/10 ps

module tb_TransferRegisterV1;
localparam period = 10; // period is 10 nanoseconds

wire [15:0] tb_Addr;

wire [15:0] tb_Bus;
reg  [15:0] tb_Bus_val;
reg         tb_Bus_dir;
assign tb_Bus = tb_Bus_dir ? tb_Bus_val : 16'bZ;

wire [7:0]  tb_MainBus;
reg  [7:0]  tb_MainBus_val;
reg         tb_MainBus_dir;
assign tb_MainBus = tb_MainBus_dir ? tb_MainBus_val : 8'bZ;

reg tb_a_tl_n;
reg tb_l_tl_n;
reg tb_a_th_n;
reg tb_l_th_n;
reg tb_l_tx_n;
reg tb_a_tx_addr_n;
reg tb_a_tx_xfer_n;

TransferRegisterV1 DUT (
	.Addr(tb_Addr),
	.Bus(tb_Bus),
	.MainBus(tb_MainBus),
	.a_tl_n(tb_a_tl_n),
	.l_tl_n(tb_l_tl_n),
	.a_th_n(tb_a_th_n),
	.l_th_n(tb_l_th_n),
	.l_tx_n(tb_l_tx_n),
	.a_tx_addr_n(tb_a_tx_addr_n),
	.a_tx_xfer_n(tb_a_tx_xfer_n)
);

    initial
    begin
	
		// idle state
		tb_MainBus_val	= 8'h55;
		tb_MainBus_dir	= 0;
		tb_Bus_val		= 16'h0;
		tb_Bus_dir		= 0;
		tb_a_tl_n		= 1;
		tb_l_tl_n		= 1;
		tb_a_th_n		= 1;
		tb_l_th_n		= 1;
		tb_l_tx_n		= 1;
		tb_a_tx_addr_n	= 1;
		tb_a_tx_xfer_n	= 1;
		#period; // wait
	
		// drive data onto MainBus
		tb_MainBus_val	= 8'h55;
		tb_MainBus_dir	= 1;
		tb_Bus_val		= 16'h0;
		tb_Bus_dir		= 0;
		tb_a_tl_n		= 1;
		tb_l_tl_n		= 1;
		tb_a_th_n		= 1;
		tb_l_th_n		= 1;
		tb_l_tx_n		= 1;
		tb_a_tx_addr_n	= 1;
		tb_a_tx_xfer_n	= 1;
		#period; // wait
	
		// load txreg high from mainbus
		tb_MainBus_val	= 8'h55;
		tb_MainBus_dir	= 1;
		tb_Bus_val		= 16'h0;
		tb_Bus_dir		= 0;
		tb_a_tl_n		= 1;
		tb_l_tl_n		= 1;
		tb_a_th_n		= 1;
		tb_l_th_n		= 0;
		tb_l_tx_n		= 1;
		tb_a_tx_addr_n	= 1;
		tb_a_tx_xfer_n	= 1;
		#period; // wait
		tb_l_th_n		= 1;
		tb_MainBus_dir	= 0;
		#period; // wait
		
		// load txreg low from mainbus
		tb_MainBus_val	= 8'hAA;
		tb_MainBus_dir	= 1;
		tb_Bus_val		= 16'h0;
		tb_Bus_dir		= 0;
		tb_a_tl_n		= 1;
		tb_l_tl_n		= 0;
		tb_a_th_n		= 1;
		tb_l_th_n		= 1;
		tb_l_tx_n		= 1;
		tb_a_tx_addr_n	= 1;
		tb_a_tx_xfer_n	= 1;
		#period; // wait
		tb_l_tl_n		= 1;
		tb_MainBus_dir	= 0;
		#period; // wait
		
		// assert to the address bus and release
		tb_a_tx_addr_n	= 0;
		#period; // wait
		tb_a_tx_addr_n	= 1;
		#period; // wait
		
		// drive transfer bus
		tb_Bus_val		= 16'h1234;
		tb_Bus_dir		= 1;
		#period; // wait
		
		// load from transfer bus
		tb_l_tx_n		= 0;
		#period; // wait
		tb_l_tx_n		= 1;
		tb_Bus_dir		= 0; // undrive bus.
		#period; // wait
	
		// assert to the xfer bus and release
		tb_a_tx_xfer_n	= 0;
		#period; // wait
		tb_a_tx_xfer_n	= 1;
		#period; // wait
	
		// assert to the main bus high and release
		tb_a_th_n	= 0;
		#period; // wait
		tb_a_th_n	= 1;
		#period; // wait
		
		// assert to the main bus low and release
		tb_a_tl_n	= 0;
		#period; // wait
		tb_a_tl_n	= 1;
		#period; // wait
	
        $finish;
    end
endmodule // end testbench