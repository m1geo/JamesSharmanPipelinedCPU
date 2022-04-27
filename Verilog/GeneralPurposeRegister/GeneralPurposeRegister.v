/*

Name:				General Purpose Register V1
Schematic Source:   https://easyeda.com/weirdboyjim/general-purpose-register
Schematic Rev:		1.0 (2019-01-13)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-04-27)

Module notes:
    Video:          https://www.youtube.com/watch?v=kz42fFKgvHE
	Module latches from MainBus into Q_reg on rising LOAD and drives to LHS, RHS or MainBus on low ASSERT lines.
	
*/

module GeneralPurposeRegister (
	inout	[7:0] 	MainBus,
	output	[7:0]	LHSBus,
	output	[7:0]	RHSBus,
	input			load,		// active rising
	input			a_main_n,	// active low
	input			a_lhs_n,	// active low
	input			a_rhs_n		// active low
);

	// Module is a super simple latch 
	reg [7:0] Q_reg;
	
	// Copy to register on LOW->HIGH of load
	always @ (posedge load)
		Q_reg <= MainBus;
	
	// assert to main bus when assert is LOW; else High-Z.
	assign MainBus = a_main_n ? 8'bZ : Q_reg;
	
	// assert to LHS bus when assert is LOW; else High-Z.
	assign LHSBus = a_lhs_n ? 8'bZ : Q_reg;
	
	// assert to RHS bus when assert is LOW; else High-Z.
	assign RHSBus = a_rhs_n ? 8'bZ : Q_reg;


endmodule