/*

Name:				Pipeline Stage 1 - TESTBENCH

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-05-20)

Module notes:
    Testbench for Pipeline Stage 1
    ROM generation code is available from James. bin2mem.py will convert to memory files for Verilog. 
    First half of simulation, reset is asserted.
*/

// unimportant timescale.
`timescale 1 ns/10 ps

module tb_PipelineStage1;
localparam period = 10; // period is 10 nanoseconds

reg       tb_clk;
reg [7:0] tb_PipeIn;
reg       tb_BusRequest;
reg       tb_Flags_0_Overflow;
reg       tb_Flags_1_Sign;
reg       tb_Flags_2_Zero;
reg       tb_Flags_3_CarryA;
reg       tb_Flags_4_CarryL;
reg       tb_Flags_5_PCRA_Flip;
reg       tb_Flags_6_Reset;

integer i;

wire [7:0] tb_PipeOut;
wire       tb_Pipe1Out_0_LHS0;
wire       tb_Pipe1Out_1_LHS1;
wire       tb_Pipe1Out_2_RHS0;
wire       tb_Pipe1Out_3_RHS1;
wire       tb_Pipe1Out_4_ALUOP0;
wire       tb_Pipe1Out_5_ALUOP1;
wire       tb_Pipe1Out_6_ALUOP2;
wire       tb_Pipe1Out_7_ALUOP3;
wire       tb_Pipe1Out_8_XLD0;
wire       tb_Pipe1Out_9_XLD1;
wire       tb_Pipe1Out_10_XLD2;
wire       tb_Pipe1Out_11_XLD3;
wire       tb_Pipe1Out_12_XA0;
wire       tb_Pipe1Out_13_XA1;
wire       tb_Pipe1Out_14_XA2;
wire       tb_Pipe1Out_15_FetchSurpress;

PipelineStage1 DUT (
	.ClockIn(tb_clk), // in
	.BusRequest(tb_BusRequest), // in
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
	.Pipe1Out_0_LHS0(tb_Pipe1Out_0_LHS0),
	.Pipe1Out_1_LHS1(tb_Pipe1Out_1_LHS1),
	.Pipe1Out_2_RHS0(tb_Pipe1Out_2_RHS0),
	.Pipe1Out_3_RHS1(tb_Pipe1Out_3_RHS1),
	.Pipe1Out_4_ALUOP0(tb_Pipe1Out_4_ALUOP0),
	.Pipe1Out_5_ALUOP1(tb_Pipe1Out_5_ALUOP1),
	.Pipe1Out_6_ALUOP2(tb_Pipe1Out_6_ALUOP2),
	.Pipe1Out_7_ALUOP3(tb_Pipe1Out_7_ALUOP3),
	.Pipe1Out_8_XLD0(tb_Pipe1Out_8_XLD0),
	.Pipe1Out_9_XLD1(tb_Pipe1Out_9_XLD1),
	.Pipe1Out_10_XLD2(tb_Pipe1Out_10_XLD2),
	.Pipe1Out_11_XLD3(tb_Pipe1Out_11_XLD3),
	.Pipe1Out_12_XA0(tb_Pipe1Out_12_XA0),
	.Pipe1Out_13_XA1(tb_Pipe1Out_13_XA1),
	.Pipe1Out_14_XA2(tb_Pipe1Out_14_XA2),
	.Pipe1Out_15_FetchSurpress(tb_Pipe1Out_15_FetchSurpress)
);

	// generate clock
    always #(period/2) tb_clk=~tb_clk;

    initial begin
		// inital values
		tb_clk = 0;
		#(4*period/5);
		
		// walk through all combinations BusRequest and Flags [6:0].
		for (i=0; i<256; i=i+1) begin // 8 bits
			tb_PipeIn = $random; // random byte (gets chopped by assignment)
			tb_BusRequest = i[0];
			tb_Flags_0_Overflow = i[1];
			tb_Flags_1_Sign = i[2];
			tb_Flags_2_Zero = i[3];
			tb_Flags_3_CarryA = i[4];
			tb_Flags_4_CarryL = i[5];
			tb_Flags_5_PCRA_Flip = i[6];
			tb_Flags_6_Reset = i[7];
			#(period);
		end

        $finish;
    end
endmodule // end testbench