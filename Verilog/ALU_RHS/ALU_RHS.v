/*

Name:				ALU RHS Bitwise Logic
Schematic Source:   https://easyeda.com/weirdboyjim/alu-rhs
Schematic Rev:		1.0 (2020-11-25)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-05-13)

Module notes:
	Video1:		https://www.youtube.com/watch?v=pMV_0qT0uY0 (design of logic)
	Video2:		https://www.youtube.com/watch?v=3k-Batj7t-0 (design of PCB + register)
	
	Design based on Julian Ilett's video on the 74LS253 as a configurable
	logic gate: https://www.youtube.com/watch?v=15M63Zqkthk
	
	Functions provided:
		(AC[3:0]=4'b1100) RHS straight through
		(AC[3:0]=4'b0011) inverted RHS (for subtraction) 
		(AC[3:0]=4'b0000) Zero operation
		(AC[3:0]=4'b1111) 255 output
		(AC[3:0]=4'b1000) LHS AND RHS
		(AC[3:0]=4'b1110) LHS OR RHS
		(AC[3:0]=4'b0110) LHS XOR RHS
*/

module ALU_RHS (
	input 			AluClock,
	input	[7:0] 	LHS,
	input	[7:0] 	RHS,
	output	[7:0]	Logic,
	
	// RHS Control
	input			AC0_RHS0,
	input			AC1_RHS1,
	input			AC2_RHS2,
	input			AC3_RHS3
);
	
	// mux outputs 
	wire [7:0] mux_out;
	
	// Loop to unroll the MUXes
	genvar i;
	generate
		for (i = 0; i < 8 ; i = i + 1) begin // Bus[7:0]
			assign mux_out[i] = RHS[i] ? (LHS[i] ? AC3_RHS3 : AC2_RHS2) : (LHS[i] ? AC1_RHS1 : AC0_RHS0);
		end
	endgenerate 

	// registers on the RHS PCB (on control breadboard)
	reg [7:0] reg_da = 0;
	always @ (posedge AluClock) begin
		reg_da <= mux_out;
	end
	
	assign Logic = reg_da; // data out

endmodule
