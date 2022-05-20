/*

Name:				Pipeline Stage 1
Schematic Source:   https://easyeda.com/weirdboyjim/Pipeline-Stage-1
Schematic Rev:		1.0 (2019-01-13)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
	Video: https://www.youtube.com/watch?v=GkUddJNc24c
*/

module PipelineStage1 (
	// PCB delays ClockIn by two NAND inverters to Clock. This doesn't.	
	input			ClockIn,
	input			BusRequest,
	input	[7:0] 	PipeIn,
	output	[7:0]	PipeOut,
	
	// control outputs
	output			Pipe1Out_0_LHS0,
	output			Pipe1Out_1_LHS1,
	output			Pipe1Out_2_RHS0,
	output			Pipe1Out_3_RHS1,
	output			Pipe1Out_4_ALUOP0,
	output			Pipe1Out_5_ALUOP1,
	output			Pipe1Out_6_ALUOP2,
	output			Pipe1Out_7_ALUOP3,
	output			Pipe1Out_8_XLD0,
	output			Pipe1Out_9_XLD1,
	output			Pipe1Out_10_XLD2,
	output			Pipe1Out_11_XLD3,
	output			Pipe1Out_12_XA0,
	output			Pipe1Out_13_XA1,
	output			Pipe1Out_14_XA2,
	output			Pipe1Out_15_FetchSurpress,
	
	// flag inputs
	input			Flags_0_Overflow,
	input			Flags_1_Sign,
	input			Flags_2_Zero,
	input			Flags_3_CarryA,
	input			Flags_4_CarryL,
	input			Flags_5_PCRA_Flip,
	input			Flags_6_Reset
);

	// Paths to ROM Files
	localparam PipeRom1A_File = "Pipe1A.mem";
	localparam PipeRom1B_File = "Pipe1B.mem";

	// Rom elements
	reg [7:0] RomA [0:32767];
	reg [7:0] RomB [0:32767];

	// Load ROMs from files
	initial begin
		$readmemh(PipeRom1A_File, RomA);
		$readmemh(PipeRom1B_File, RomB);
	end

	wire [14:0] addr;
	assign addr = {Flags_6_Reset, Flags_5_PCRA_Flip, Flags_4_CarryL, Flags_3_CarryA, 
					Flags_2_Zero, Flags_1_Sign, Flags_0_Overflow, PipeIn[7:0]};

	// Design latches Rom outputs
	reg [7:0] LatchedRomA;
	reg [7:0] LatchedRomB;
	reg [7:0] PipeLatch;
	always @ (posedge ClockIn) begin
		PipeLatch <= PipeIn;
		LatchedRomA <= RomA[addr]; // flipped twice in hw
		LatchedRomB <= RomB[addr]; // flipped twice in hw
	end
	
	wire PassOut = ~(BusRequest & Pipe1Out_15_FetchSurpress);
	assign PipeOut = {8{PassOut}} & PipeLatch;
	
	assign Pipe1Out_0_LHS0 = LatchedRomA[0];
	assign Pipe1Out_1_LHS1 = LatchedRomA[1];
	assign Pipe1Out_2_RHS0 = LatchedRomA[2];
	assign Pipe1Out_3_RHS1 = LatchedRomA[3];
	assign Pipe1Out_4_ALUOP0 = LatchedRomA[4];
	assign Pipe1Out_5_ALUOP1 = LatchedRomA[5];
	assign Pipe1Out_6_ALUOP2 = LatchedRomA[6];
	assign Pipe1Out_7_ALUOP3 = LatchedRomA[7];
	assign Pipe1Out_8_XLD0 = LatchedRomB[0];
	assign Pipe1Out_9_XLD1 = LatchedRomB[1];
	assign Pipe1Out_10_XLD2 = LatchedRomB[2];
	assign Pipe1Out_11_XLD3 = LatchedRomB[3];
	assign Pipe1Out_12_XA0 = LatchedRomB[4];
	assign Pipe1Out_13_XA1 = LatchedRomB[5];
	assign Pipe1Out_14_XA2 = LatchedRomB[6];
	assign Pipe1Out_15_FetchSurpress = LatchedRomB[7];
	
endmodule