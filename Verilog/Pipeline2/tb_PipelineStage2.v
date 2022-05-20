/*

Name:				Pipeline Stage 2 - TESTBENCH

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-05-20)

Module notes:
    Testbench for Pipeline Stage 2
    ROM generation code is available from James. bin2mem.py will convert to memory files for Verilog. 
    First half of simulation, reset is asserted.
*/

// unimportant timescale.
`timescale 1 ns/10 ps

module tb_PipelineStage2;
localparam period = 10; // period is 10 nanoseconds

reg       tb_clk;
reg [7:0] tb_PipeIn;
reg       tb_Flags_0_Overflow;
reg       tb_Flags_1_Sign;
reg       tb_Flags_2_Zero;
reg       tb_Flags_3_CarryA;
reg       tb_Flags_4_CarryL;
reg       tb_Flags_5_PCRA_Flip;
reg       tb_Flags_6_Reset;

integer i;

wire [7:0] tb_PipeOut;
wire       tb_Pipe2Out_0_MainAssert0;
wire       tb_Pipe2Out_1_MainAssert1;
wire       tb_Pipe2Out_2_MainAssert2;
wire       tb_Pipe2Out_3_MainAssert3;
wire       tb_Pipe2Out_4_MainLoad0;
wire       tb_Pipe2Out_5_MainLoad1;
wire       tb_Pipe2Out_6_MainLoad2;
wire       tb_Pipe2Out_7_MainLoad3;
wire       tb_Pipe2Out_8_Inc0;
wire       tb_Pipe2Out_9_Inc1;
wire       tb_Pipe2Out_10_Addr0;
wire       tb_Pipe2Out_11_Addr1;
wire       tb_Pipe2Out_12_Addr2;
wire       tb_Pipe2Out_13_BusRequest;
wire       tb_Pipe2Out_14_PCRA_Flip;
wire       tb_Pipe2Out_15_Break;

PipelineStage2 DUT (
	.ClockIn(tb_clk), // in
	.PipeIn(tb_PipeIn), // in [7:0]
	.PipeOut(tb_PipeOut), // out [7:0]
	
	// flag inputs (all single bit inputs)
	.Flags_0_Overflow(tb_Flags_0_Overflow),
	.Flags_1_Sign(tb_Flags_1_Sign),
	.Flags_2_Zero(tb_Flags_2_Zero),
	.Flags_3_CarryA(tb_Flags_3_CarryA),
	.Flags_4_CarryL(tb_Flags_4_CarryL),
	.Flags_5_PCRA_Flip(tb_Flags_5_PCRA_Flip),
	.Flags_6_Reset(tb_Flags_6_Reset),
	
	// control outputs (all single bit outputs)
	.Pipe2Out_0_MainAssert0(tb_Pipe2Out_0_MainAssert0),
	.Pipe2Out_1_MainAssert1(tb_Pipe2Out_1_MainAssert1),
	.Pipe2Out_2_MainAssert2(tb_Pipe2Out_2_MainAssert2),
	.Pipe2Out_3_MainAssert3(tb_Pipe2Out_3_MainAssert3),
	.Pipe2Out_4_MainLoad0(tb_Pipe2Out_4_MainLoad0),
	.Pipe2Out_5_MainLoad1(tb_Pipe2Out_5_MainLoad1),
	.Pipe2Out_6_MainLoad2(tb_Pipe2Out_6_MainLoad2),
	.Pipe2Out_7_MainLoad3(tb_Pipe2Out_7_MainLoad3),
	.Pipe2Out_8_Inc0(tb_Pipe2Out_8_Inc0),
	.Pipe2Out_9_Inc1(tb_Pipe2Out_9_Inc1),
	.Pipe2Out_10_Addr0(tb_Pipe2Out_10_Addr0),
	.Pipe2Out_11_Addr1(tb_Pipe2Out_11_Addr1),
	.Pipe2Out_12_Addr2(tb_Pipe2Out_12_Addr2),
	.Pipe2Out_13_BusRequest(tb_Pipe2Out_13_BusRequest),
	.Pipe2Out_14_PCRA_Flip(tb_Pipe2Out_14_PCRA_Flip),
	.Pipe2Out_15_Break(tb_Pipe2Out_15_Break)
);

	// generate clock
    always #(period/2) tb_clk=~tb_clk;

    initial begin
		// inital values
		tb_clk = 0;
		#(4*period/5);
		
		// walk through all combinations Flags [6:0].
		for (i=0; i<128; i=i+1) begin // 7 bits
			tb_PipeIn = $random; // random byte (gets chopped by assignment)
			tb_Flags_0_Overflow = i[0];
			tb_Flags_1_Sign = i[1];
			tb_Flags_2_Zero = i[2];
			tb_Flags_3_CarryA = i[3];
			tb_Flags_4_CarryL = i[4];
			tb_Flags_5_PCRA_Flip = i[5];
			tb_Flags_6_Reset = i[6];
			#(period);
		end

        $finish;
    end
endmodule // end testbench