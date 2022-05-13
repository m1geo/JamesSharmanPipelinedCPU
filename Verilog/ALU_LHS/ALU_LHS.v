/*

Name:				ALU LHS Shift
Schematic Source:   https://easyeda.com/weirdboyjim/alu-lhs
Schematic Rev:		1.0 (2020-11-25)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-05-13)

Module notes:
	Video1: https://www.youtube.com/watch?v=fxx9tfUoYCY (design of shifter)
	Video2: https://www.youtube.com/watch?v=gAJ1tzGgKNw (design of PCB + register)
	
*/

module ALU_LHS (
	input 			AluClock,
	input	[7:0] 	LHS,
	output	[7:0]	Shift,
	
	// LHS Control
	input			AC4_LHS0,
	input			AC5_LHS1,
	input			LCarryIn,
	output			LCarryOut
);

	// C0 (unchanged)
	wire [7:0] C0_da = LHS;
	wire       C0_co = 1'b0; // PCB Jumper "NC_CIr" (fitted in Video2 21:22)
	//wire       C0_co = LCarryIn; // PCB Jumper "NC_CIn"

	// C1 (shift left <--)
	wire [7:0] C1_da  = {LHS[6:0], LCarryIn};
	wire       C1_co  = LHS[7];

	// C2 (shift right-->)
	wire [7:0] C2_da  = {LCarryIn, LHS[7:1]};
	wire       C2_co  = LHS[0];

	// C3 (zero)
	wire [7:0] C3_da = 8'b0;
	wire       C3_co = 1'b0;

	// The MUX
	wire [7:0] mux_da;
	wire       mux_co;
	
	// mux the 4 different states.
	assign mux_da = AC5_LHS1 ? (AC4_LHS0 ? C3_da : C2_da) : (AC4_LHS0 ? C1_da : C0_da);
	assign mux_co = AC5_LHS1 ? (AC4_LHS0 ? C3_co : C2_co) : (AC4_LHS0 ? C1_co : C0_co);
	
	// registers on the LHS PCB (on control breadboard)
	reg [7:0] reg_da = 0;
	reg       reg_co = 0;
	always @ (posedge AluClock) begin
		reg_da <= mux_da;
		reg_co <= mux_co;
	end
	
	assign Shift = reg_da; // data out
	assign LCarryOut = reg_co; // carry out

endmodule
