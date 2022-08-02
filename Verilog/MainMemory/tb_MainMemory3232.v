/*

Name:				MainMemory 3232 - TESTBENCH

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-05-20)

Module notes:
    Testbench for MainMemory 32k/32k
*/

// unimportant timescale.
`timescale 1 ns/10 ps

module tb_MainMemory3232;
localparam period = 10; // period is 10 nanoseconds

reg [15:0] tb_Addr;
reg  [7:0] tb_MainBus_val; // tristate workaround
reg        tb_MainBus_dir; // tristate workaround
wire [7:0] tb_MainBus;
assign tb_MainBus = tb_MainBus_dir ? tb_MainBus_val : 8'bZ;
reg        tb_MemBridge_Load;
reg        tb_MemBridge_Direction;

integer i;

MainMemory3232 DUT (
	.Addr(tb_Addr), // in [15:0]
	.MEMDATA(tb_MainBus), // inout [7:0]
	
	// Mem Inputs
	.MemBridge_Load(tb_MemBridge_Load),
	.MemBridge_Direction(tb_MemBridge_Direction) // high = memory module output
);

    initial begin
		// inital values
		tb_MainBus_val = 0;
		tb_MainBus_dir = 0;
		tb_MemBridge_Load = 1; // active low
		tb_MemBridge_Direction = 0;
		#(4*period/5);
		
		// Read first 5 addresses from ROM
		$display("Read first 5 ROM bytes");
		for (i=0; i<5; i=i+1) begin // 7 bits
			tb_Addr = i[14:0];
			tb_Addr[15] = 0; // override to ROM
			tb_MemBridge_Direction = 1; // mem output
			#(period/2);
			tb_MemBridge_Direction = 0; // mem hi-z
			#(period/2);
		end
		
		// Read first 5 addresses from RAM
		$display("Read first 5 RAM bytes");
		for (i=0; i<5; i=i+1) begin // 7 bits
			tb_Addr = i[14:0];
			tb_Addr[15] = 1; // override to RAM
			tb_MemBridge_Direction = 1; // mem output
			#(period/2);
			tb_MemBridge_Direction = 0; // mem hi-z
			#(period/2);
		end
		
		// Write first 5 addresses from RAM
		$display("Write first 5 ROM bytes");
		for (i=0; i<5; i=i+1) begin // 7 bits
		    tb_MainBus_val = $random;
		    tb_MainBus_dir = 1; // drive main bus
			tb_Addr = i[14:0];
			tb_Addr[15] = 1; // override to RAM
			#1; //tiny delay to allow data to setup before write
			tb_MemBridge_Load = 0;  // ram write (act low)
			#(period/2);
			tb_MemBridge_Load = 1;  // ram read (act low for write)
			tb_MainBus_dir = 0;
			#(period/2);
		end
		
		// Read first 5 addresses from RAM
		$display("Read first 5 RAM bytes");
		for (i=0; i<5; i=i+1) begin // 7 bits
			tb_Addr = i[14:0];
			tb_Addr[15] = 1; // override to RAM
			tb_MemBridge_Direction = 1; // mem output
			#(period/2);
			tb_MemBridge_Direction = 0; // mem hi-z
			#(period/2);
		end

        $finish;
    end
endmodule // end testbench