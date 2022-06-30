/*

Name:				Main ALU

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
	This module joins the ALU sections together
	AluClock should probably be removed and propagate AluActive to always block enables.
*/


// Include Submodules.
//`include "ALU_Control/ALU_Control.v"
//`include "ALU_Output/ALU_Output.v"
//`include "ALU_LHS/ALU_LHS.v"
//`include "ALU_RHS/ALU_RHS.v"


module ALU (

	input 			Clock,
	
	// MAINBUS
	inout	[7:0]	MainBus,
	
	// GPR ALU BUSES
	input	[7:0] 	LHS,
	input	[7:0] 	RHS,
	
	// ALU OP Input
	input			Pipe1Out_4_ALUOP0,
	input			Pipe1Out_5_ALUOP1,
	input			Pipe1Out_6_ALUOP2,
	input			Pipe1Out_7_ALUOP3,
	
	// FLAGS
	output			Flags_0_Overflow,
	output			Flags_1_Sign,
	output			Flags_2_Zero,
	output			Flags_3_CarryA,
	output			Flags_4_CarryL,

	// CARRYCTRL
	input			LCarryIn,
	input			Alu_Assert //active low
);


	// ALU Control
	wire AluClock;
	wire AluActive;
	wire [3:0] alu_opcode;
	wire [1:0] ac_lhs;
	wire [3:0] ac_rhs;
	wire [1:0] ac_cs;
	
	ALU_Control alucontrol (
		.Clock(Clock),
		.Pipe1Out_4_ALUOP0(Pipe1Out_4_ALUOP0),
		.Pipe1Out_5_ALUOP1(Pipe1Out_5_ALUOP1),
		.Pipe1Out_6_ALUOP2(Pipe1Out_6_ALUOP2),
		.Pipe1Out_7_ALUOP3(Pipe1Out_7_ALUOP3),
		.AluClock_bufgce(AluClock),
		//.AluClock_and(AluClock),
		.AluActive(AluActive),
		.AC0_RHS0(ac_rhs[0]),
		.AC1_RHS1(ac_rhs[1]),
		.AC2_RHS2(ac_rhs[2]),
		.AC3_RHS3(ac_rhs[3]),
		.AC4_LHS0(ac_lhs[0]),
		.AC5_LHS1(ac_lhs[1]),
		.AC6_CS0(ac_cs[0]),
		.AC7_CS1(ac_cs[1])
	);

	// LHS Shift
	wire [7:0] lhsshiftout;
	wire       lhsshiftcarryout;
	ALU_LHS alulhs (
		.AluClock(AluClock),
		.LHS(LHS),
		.Shift(lhsshiftout), // out
		.AC4_LHS0(ac_lhs[0]),
		.AC5_LHS1(ac_lhs[1]),
		.LCarryIn(LCarryIn),
		.LCarryOut(lhsshiftcarryout) // out
	);
	
	// RHS Logic
	wire [7:0] rhslogicout;
	ALU_RHS alurhs (
		.AluClock(AluClock),
		.LHS(LHS),
		.RHS(RHS),
		.Logic(rhslogicout), // out
		.AC0_RHS0(ac_rhs[0]),
		.AC1_RHS1(ac_rhs[1]),
		.AC2_RHS2(ac_rhs[2]),
		.AC3_RHS3(ac_rhs[3])
	);

	// ALU Output/Result (adder & flags)
	ALU_Output aluoutput (
		.AluClock(AluClock), // in
		.MainBus(MainBus), // out
		.Shift(lhsshiftout), // in 
		.Logic(rhslogicout), // in
		.Flags_0_Overflow(Flags_0_Overflow), //out
		.Flags_1_Sign(Flags_1_Sign), //out
		.Flags_2_Zero(Flags_2_Zero), //out
		.Flags_3_CarryA(Flags_3_CarryA), //out
		.Flags_4_CarryL(Flags_4_CarryL), //out
	
		.LCARRYNEW(lhsshiftcarryout), //in
		.AC6_CS0(ac_cs[0]), //in
		.AC7_CS1(ac_cs[1]), //in
		.Alu_Assert(Alu_Assert) //in
	);

endmodule
