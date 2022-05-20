/*

Name:				Pipeline Stage 2
Schematic Source:   https://easyeda.com/weirdboyjim/pipeline-stage-2
Schematic Rev:		1.0 (2019-01-13)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
	Video: https://www.youtube.com/watch?v=GkUddJNc24c	
*/

module PipelineStage2 (
	// PCB delays ClockIn by two NAND inverters to Clock. This doesn't.
	input			ClockIn,
	
	input	[7:0] 	PipeIn,
	output	[7:0]	PipeOut,
	
	// control outputs
	output			Pipe2Out_0_MainAssert0,
	output			Pipe2Out_1_MainAssert1,
	output			Pipe2Out_2_MainAssert2,
	output			Pipe2Out_3_MainAssert3,
	output			Pipe2Out_4_MainLoad0,
	output			Pipe2Out_5_MainLoad1,
	output			Pipe2Out_6_MainLoad2,
	output			Pipe2Out_7_MainLoad3,
	output			Pipe2Out_8_Inc0,
	output			Pipe2Out_9_Inc1,
	output			Pipe2Out_10_Addr0,
	output			Pipe2Out_11_Addr1,
	output			Pipe2Out_12_Addr2,
	output			Pipe2Out_13_BusRequest,
	output			Pipe2Out_14_PCRA_Flip,
	output			Pipe2Out_15_Break,
	
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
	localparam PipeRom2A_File = "Pipe2A.mem";
	localparam PipeRom2B_File = "Pipe2B.mem";

	// Rom elements
	reg [7:0] RomA [0:32767];
	reg [7:0] RomB [0:32767];

	// Load ROMs from files
	initial begin
		$readmemh(PipeRom2A_File, RomA);
		$readmemh(PipeRom2B_File, RomB);
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

	assign PipeOut = PipeLatch;
	
	assign Pipe2Out_0_MainAssert0 = LatchedRomA[0];
	assign Pipe2Out_1_MainAssert1 = LatchedRomA[1];
	assign Pipe2Out_2_MainAssert2 = LatchedRomA[2];
	assign Pipe2Out_3_MainAssert3 = LatchedRomA[3];
	assign Pipe2Out_4_MainLoad0 = LatchedRomA[4];
	assign Pipe2Out_5_MainLoad1 = LatchedRomA[5];
	assign Pipe2Out_6_MainLoad2 = LatchedRomA[6];
	assign Pipe2Out_7_MainLoad3 = LatchedRomA[7];
	assign Pipe2Out_8_Inc0 = LatchedRomB[0];
	assign Pipe2Out_9_Inc1 = LatchedRomB[1];
	assign Pipe2Out_10_Addr0 = LatchedRomB[2];
	assign Pipe2Out_11_Addr1 = LatchedRomB[3];
	assign Pipe2Out_12_Addr2 = LatchedRomB[4];
	assign Pipe2Out_13_BusRequest = LatchedRomB[5];
	assign Pipe2Out_14_PCRA_Flip = LatchedRomB[6];
	assign Pipe2Out_15_Break = LatchedRomB[7];

endmodule