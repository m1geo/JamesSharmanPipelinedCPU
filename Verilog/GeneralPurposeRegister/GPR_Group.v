/*

Name:				General Purpose Register Group

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
	This module joins the four GPRs together. Not massively useful, but tider on top level view.
*/

// Include Submodules.
`include "GeneralPurposeRegister.v


module GPR_Group (
	inout	[7:0] 	MainBus,
	output	[7:0]	LHSBus,
	output	[7:0]	RHSBus,
	
	// GPR A
	input			a_load,
	input			a_main_assert,
	input			a_lhs_assert,
	input			a_rhs_assert,
	
	// GPR B
	input			b_load,
	input			b_main_assert,
	input			b_lhs_assert,
	input			b_rhs_assert,
	
	// GPR C
	input			c_load,
	input			c_main_assert,
	input			c_lhs_assert,
	input			c_rhs_assert,
	
	// GPR D
	input			d_load,
	input			d_main_assert,
	input			d_lhs_assert,
	input			d_rhs_assert
);

	// GPR A
	GeneralPurposeRegister gprA (
		.MainBus(MainBus),
		.LHSBus(LHSBus),
		.RHSBus(RHSBus),
		.load(a_load),
		.a_main_n(a_main_assert),
		.a_lhs_n(a_lhs_assert),
		.a_rhs_n(a_rhs_assert)
	);
	
	// GPR B
	GeneralPurposeRegister gprB (
		.MainBus(MainBus),
		.LHSBus(LHSBus),
		.RHSBus(RHSBus),
		.load(b_load),
		.a_main_n(b_main_assert),
		.a_lhs_n(b_lhs_assert),
		.a_rhs_n(b_rhs_assert)
	);
	
	// GPR C
	GeneralPurposeRegister gprC (
		.MainBus(MainBus),
		.LHSBus(LHSBus),
		.RHSBus(RHSBus),
		.load(c_load),
		.a_main_n(c_main_assert),
		.a_lhs_n(c_lhs_assert),
		.a_rhs_n(c_rhs_assert)
	);
	
	// GPR D
	GeneralPurposeRegister gprD (
		.MainBus(MainBus),
		.LHSBus(LHSBus),
		.RHSBus(RHSBus),
		.load(d_load),
		.a_main_n(d_main_assert),
		.a_lhs_n(d_lhs_assert),
		.a_rhs_n(d_rhs_assert)
	);

endmodule