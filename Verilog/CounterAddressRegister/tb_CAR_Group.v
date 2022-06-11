/*

Name:				CAR Group - TESTBENCH

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-06-11)

Module notes:
    Testbench for Group of V1 couter address registers
    
*/

// unimportant timescale.
`timescale 100 ns/10 ns

module tb_CAR_Group;

wire [15:0] tb_Addr;

wire [15:0] tb_Xbus;
reg  [15:0] tb_Xbus_val;
reg         tb_Xbus_dir = 0;
assign tb_Xbus = tb_Xbus_dir ? tb_Xbus_val : 16'bZ; //tris

reg tb_clear = 0;
reg tb_clk = 0;

reg tb_pcra0_dec = 0;
reg tb_pcra0_inc = 0;
reg tb_pcra0_xbus_load = 1;
reg tb_pcra0_xbus_assert = 1;
reg tb_pcra0_addr_assert = 1;
	
reg tb_pcra1_dec = 0;
reg tb_pcra1_inc = 0;
reg tb_pcra1_xbus_load = 1;
reg tb_pcra1_xbus_assert = 1;
reg tb_pcra1_addr_assert = 1;
	
reg tb_sp_dec = 0;
reg tb_sp_inc = 0;
reg tb_sp_xbus_load = 1;
reg tb_sp_xbus_assert = 1;
reg tb_sp_addr_assert = 1;
	
reg tb_si_dec = 0;
reg tb_si_inc = 0;
reg tb_si_xbus_load = 1;
reg tb_si_xbus_assert = 1;
reg tb_si_addr_assert = 1;
	
reg tb_di_dec = 0;
reg tb_di_inc = 0;
reg tb_di_xbus_load = 1;
reg tb_di_xbus_assert = 1;
reg tb_di_addr_assert = 1;

localparam period = 10; // period is 100 nanoseconds

// generate clock
always #(period/5) tb_clk=~tb_clk;

CAR_Group DUT (
	.Addr(tb_Addr), // io [15:0]
	.Xbus(tb_Xbus), // io [15:0]
	.clock(tb_clk), // in
	.clear(tb_clear), // in
	
	// PCRA0
	.pcra0_dec(tb_pcra0_dec),
	.pcra0_inc(tb_pcra0_inc),
	.pcra0_xbus_load(tb_pcra0_xbus_load),
	.pcra0_xbus_assert(tb_pcra0_xbus_assert),
	.pcra0_addr_assert(tb_pcra0_addr_assert),
	
	// PCRA1
	.pcra1_dec(tb_pcra1_dec),
	.pcra1_inc(tb_pcra1_inc),
	.pcra1_xbus_load(tb_pcra1_xbus_load),
	.pcra1_xbus_assert(tb_pcra1_xbus_assert),
	.pcra1_addr_assert(tb_pcra1_addr_assert),
	
	// SP
	.sp_dec(tb_sp_dec),
	.sp_inc(tb_sp_inc),
	.sp_xbus_load(tb_sp_xbus_load),
	.sp_xbus_assert(tb_sp_xbus_assert),
	.sp_addr_assert(tb_sp_addr_assert),
	
	// SI
	.si_dec(tb_si_dec),
	.si_inc(tb_si_inc),
	.si_xbus_load(tb_si_xbus_load),
	.si_xbus_assert(tb_si_xbus_assert),
	.si_addr_assert(tb_si_addr_assert),
	
	// DI
	.di_dec(tb_di_dec),
	.di_inc(tb_di_inc),
	.di_xbus_load(tb_di_xbus_load),
	.di_xbus_assert(tb_di_xbus_assert),
	.di_addr_assert(tb_di_addr_assert)
);

    integer i;
    
    reg [4:0] dummy;
	
    initial begin
        // some wait with reset
        tb_clear = 1;
        #((4*period)/5);
        tb_clear = 0;
    
		// test loads & asserts
		for (i=0; i<20; i=i+1) begin
		    tb_Xbus_dir = (i[1:0]==2'b0); // assert onto bus when loads are enabled
		    tb_Xbus_val = tb_Xbus_dir ? $random : 16'bX; // makes simulation clearer to see
		    #1; // bit of setup time for data before trying to latch it in.

		    {dummy[4], tb_di_addr_assert, tb_di_xbus_assert, tb_di_xbus_load,
		     dummy[3], tb_si_addr_assert, tb_si_xbus_assert, tb_si_xbus_load,
		     dummy[2], tb_sp_addr_assert, tb_sp_xbus_assert, tb_sp_xbus_load,
		     dummy[1], tb_pcra1_addr_assert, tb_pcra1_xbus_assert, tb_pcra1_xbus_load,
		     dummy[0], tb_pcra0_addr_assert, tb_pcra0_xbus_assert, tb_pcra0_xbus_load} = ~(1<<i); // one cold

			#(period-1);
		end
		
		// test increments (add 3)
		for (i=0; i<3; i=i+1) begin
		      {tb_di_inc, tb_si_inc, tb_sp_inc, tb_pcra1_inc, tb_pcra0_inc} = 5'h1F;
		      #(period/2);
		      {tb_di_inc, tb_si_inc, tb_sp_inc, tb_pcra1_inc, tb_pcra0_inc} = 5'h00;
		      #(period/2);
		end
		for (i=0; i<5; i=i+1) begin
		  {tb_di_addr_assert, tb_si_addr_assert, tb_sp_addr_assert, tb_pcra1_addr_assert, tb_pcra0_addr_assert} = ~(1<<i);
		  #(period);
		  {tb_di_addr_assert, tb_si_addr_assert, tb_sp_addr_assert, tb_pcra1_addr_assert, tb_pcra0_addr_assert} = 5'h1F;
		end 
		
		// test increments (sub 4)
		for (i=0; i<4; i=i+1) begin
		      {tb_di_dec, tb_si_dec, tb_sp_dec, tb_pcra1_dec, tb_pcra0_dec} = 5'h1F;
		      #(period/2);
		      {tb_di_dec, tb_si_dec, tb_sp_dec, tb_pcra1_dec, tb_pcra0_dec} = 5'h00;
		      #(period/2);
		end
		for (i=0; i<5; i=i+1) begin
		  {tb_di_addr_assert, tb_si_addr_assert, tb_sp_addr_assert, tb_pcra1_addr_assert, tb_pcra0_addr_assert} = ~(1<<i);
		  #(period);
		  {tb_di_addr_assert, tb_si_addr_assert, tb_sp_addr_assert, tb_pcra1_addr_assert, tb_pcra0_addr_assert} = 5'h1F;
		end 
		
		$finish;
    end 
endmodule // end testbench