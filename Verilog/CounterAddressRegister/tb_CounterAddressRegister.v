/*

Name:				Counter/Address Register - TESTBENCH

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-04-27)

Module notes:
    Testbench for Counter/Address Register
    
*/

// unimportant timescale.
`timescale 1 ns/10 ps

module tb_CounterAddressRegister;
localparam period = 10; // period is 10 nanoseconds

reg        tb_dec;
reg        tb_inc;
reg        tb_clk;
reg        tb_clr;
reg        tb_load_n;
reg        tb_a_bus_n;
reg        tb_a_addr_n;

wire [15:0] tb_Bus;
wire [15:0] tb_Addr;
reg  [15:0] tb_Bus_val;
reg         tb_Bus_dir;
assign tb_Bus = tb_Bus_dir ? tb_Bus_val : 16'bZ;

// generate clock
always #(period/5) tb_clk=~tb_clk;

CounterAddressRegister DUT (
	.Addr(tb_Addr),
	.Bus(tb_Bus),
	.clock(tb_clk),	
	.clear(tb_clr),		// active high
	.dec(tb_dec),		    // active rising edge
	.inc(tb_inc),		    // active rising edge
	.load_n(tb_load_n),		// active low
	.a_addr_n(tb_a_addr_n),	// active low
	.a_bus_n(tb_a_bus_n)		// active low
);

    initial
    begin
        tb_clk       = 0; //  initial clock
        tb_Bus_val   = 8'hAAAA;
        tb_Bus_dir   = 1;
        tb_dec       = 1;
        tb_inc       = 1;
        tb_clr       = 1; // clear
        tb_load_n    = 1;
        tb_a_bus_n   = 1;
        tb_a_addr_n  = 1;
        #period; // wait
        
        // load but in reset.
        tb_Bus_val   = 8'hAAAA;
        tb_Bus_dir   = 1;
        tb_dec       = 1;
        tb_inc       = 1;
        tb_clr       = 1; // clear
        tb_load_n    = 0; // latch
        tb_a_bus_n   = 1;
        tb_a_addr_n  = 1;
        #period; // wait
        
        // clear reset and load
        tb_Bus_val   = 8'hAAAA;
        tb_Bus_dir   = 1;
        tb_dec       = 1;
        tb_inc       = 1;
        tb_clr       = 0;
        tb_load_n    = 1;
        tb_a_bus_n   = 1;
        tb_a_addr_n  = 1;
        #period; // wait

        // load
        tb_Bus_val   = 8'hAAAA;
        tb_Bus_dir   = 1;
        tb_dec       = 1;
        tb_inc       = 1;
        tb_clr       = 0;
        tb_load_n    = 0; // latch
        tb_a_bus_n   = 1;
        tb_a_addr_n  = 1;
        #period; // wait

        // idle
        tb_Bus_val   = 8'h0;
        tb_Bus_dir   = 0;
        tb_dec       = 1;
        tb_inc       = 1;
        tb_clr       = 0;
        tb_load_n    = 1;
        tb_a_bus_n   = 1;
        tb_a_addr_n  = 1;
        #period; // wait
        
        // dec value twice
        tb_dec       = 1;
        #period;
        tb_dec       = 0;
        #period;
        tb_dec       = 1;
        #period;
        tb_dec       = 0;
        #period;
        tb_dec       = 1;
        #period;
        
        // sequ. assert to both busses
        tb_a_bus_n   = 0;
        #period;
        tb_a_bus_n   = 1;
        #period;
        tb_a_addr_n   = 0;
        #period;
        tb_a_addr_n   = 1;
        #period;
        
        // inc value thrice
        tb_inc       = 1;
        #period;
        tb_inc       = 0;
        #period;
        tb_inc       = 1;
        #period;
        tb_inc       = 0;
        #period;
        tb_inc       = 1;
        #period;
        tb_inc       = 0;
        #period;
        tb_inc       = 1;
        
        // idle
        tb_Bus_val   = 8'h0;
        tb_Bus_dir   = 0;
        tb_dec       = 1;
        tb_inc       = 1;
        tb_clr       = 0;
        tb_load_n    = 1;
        tb_a_bus_n   = 1;
        tb_a_addr_n  = 1;
        #period; // wait
        
        // sequ. assert to both busses
        tb_a_bus_n   = 0;
        #period;
        tb_a_bus_n   = 1;
        #period;
        tb_a_addr_n   = 0;
        #period;
        tb_a_addr_n   = 1;
        #period;
        
        $finish;
    end
endmodule // end testbench