/*

Name:				BusControl - TESTBENCH

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-05-19)

Module notes:
    Testbench for Bus Control
*/

// unimportant timescale.
`timescale 1 ns/10 ps

module tb_BusControl();
localparam period = 10; // period is 10 nanoseconds

reg tb_clk;
reg [3:0] tb_Bus_Assert;
reg [3:0] tb_Bus_Load;
reg [2:0] tb_Xfer_Assert;
reg [3:0] tb_XferLoadDec;
reg [1:0] tb_Inc_PCRA;
reg [1:0] tb_Inc_SPSIDI;
reg [1:0] tb_LHS;
reg [1:0] tb_RHS;
reg [2:0] tb_AddrSel;
reg       tb_Reset_n;
integer i;

BusControl DUT (
	// SIL8 MAINBUSCTRL
	.Bus_Assert(tb_Bus_Assert), // [3:0]
	.Bus_Load(tb_Bus_Load), // [3:0]
	
	// SIL8 XFERBUSCTRL
	.Xfer_Assert(tb_Xfer_Assert), // [2:0]
	.XferLoadDec(tb_XferLoadDec), // [3:0]
	
	// SIL4 INC
	.Inc_PCRA(tb_Inc_PCRA), // [1:0]
	.Inc_SPSIDI(tb_Inc_SPSIDI), // [1:0]
	
	// SIL4 ALUSEL
	.LHS(tb_LHS), // [1:0]
	.RHS(tb_RHS), // [1:0]
	
	// SIL4 ADDRSEL
	.AddrSel(tb_AddrSel), // [2:0]
	
	// SIL4 INPUTS
	.Clock_In(tb_clk),
	.Reset_In(tb_Reset_n)	// active low
);

	// generate clock
    always #(period/5) tb_clk=~tb_clk;

    initial begin
		// inital values
		tb_clk = 0;
		tb_Reset_n = 1;
		tb_Bus_Assert = 0;
		tb_Bus_Load = 0;
		tb_Xfer_Assert = 0;
		tb_XferLoadDec = 0;
		tb_Inc_PCRA = 0;
		tb_Inc_SPSIDI = 0;
		tb_LHS = 0;
		tb_RHS = 0;
		tb_AddrSel = 0;
		
		
		// test Bus_Assert & Bus_Load
		for (i=0; i<16; i=i+1) begin // 4 bits
			$display("Bus_Assert & Bus_Load %0d", i);
			tb_Bus_Assert = i; // 4 bits
			tb_Bus_Load = i; // 4 bits
			#period;
		end
		tb_Bus_Assert = 0;
		tb_Bus_Load = 0;
		
		
		// test Transfer Bus Load/Dec
		for (i=0; i<16; i=i+1) begin 
			$display("Transfer Bus Load/Dec %0d", i);
			tb_XferLoadDec = i; // 4 bits
			tb_Xfer_Assert = i[3:1]; // 3 bits
			#period;
		end
		tb_XferLoadDec = 0;
		tb_Xfer_Assert = 0;
        
        
        // test Inc_PCRA & Inc_SPSIDI
		for (i=0; i<4; i=i+1) begin 
			$display("Inc_PCRA & Inc_SPSIDI %0d", i);
			tb_Inc_PCRA = i; // 2 bits
			tb_Inc_SPSIDI = i; // 2 bits
			#period;
		end
		tb_Inc_PCRA = 0;
		tb_Inc_SPSIDI = 0;
        
        
        // test LHS and RHS
		for (i=0; i<4; i=i+1) begin 
			$display("LHS and RHS %0d", i);
			tb_LHS = i; // 2 bits
			tb_RHS = i; // 2 bits
			#period;
		end
		tb_LHS = 0;
		tb_RHS = 0;
        
        
        // test ADDRSEL
		for (i=0; i<8; i=i+1) begin 
			$display("ADDRSEL %0d", i);
			tb_AddrSel = i; // 3 bits
			#period;
		end
		tb_AddrSel = 0;
		
        // test Reset passthrough?
		for (i=0; i<4; i=i+1) begin 
			$display("Reset %0d", i[0]);
			tb_Reset_n = i[0]; // 1 bit
			#period;
		end
		tb_Reset_n = 1;
		
        $finish;
    end
endmodule // end testbench