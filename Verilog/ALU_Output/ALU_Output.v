/*

Name:				ALU Output (also called ALU Result)
Schematic Source:   https://easyeda.com/weirdboyjim/alu-output
Schematic Rev:		1.0 (2020-11-25)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-05-14)

Module notes:
	Video:			https://www.youtube.com/watch?v=2PUC_Baumbg (design)
	Video:			https://www.youtube.com/watch?v=UCk36aS62P4 (PCB)
	
*/

module ALU_Output (

	input 			AluClock,
	
	// MAINBUS
	output	[7:0]	MainBus,
	
	// SHIFTOUT3 (LHS)
	input	[7:0]	Shift,

	// LOGICOUT3 (RHS)
	input	[7:0]	Logic,

	// FLAGS
	output			Flags_0_Overflow,
	output			Flags_1_Sign,
	output			Flags_2_Zero,
	output			Flags_3_CarryA,
	output			Flags_4_CarryL,

	// CARRYCTRL
	input			LCARRYNEW,
	input			AC6_CS0,
	input			AC7_CS1,
	input			Alu_Assert //active low
);

	// Adder result output
	wire [7:0] Res;
	wire ACarryOut;
	wire ACarryIn;
	
	// Delay signals by clock cycle to match with pipeline
	// These signals are dispatched by an earlier pipeline stage
	reg CarrySelect0;
	reg CarrySelect1;
	reg Flags_4_CarryL_reg;
	reg ACarryPrev;
	always @ (posedge AluClock) begin
		CarrySelect0       <= AC6_CS0;
		CarrySelect1       <= AC7_CS1;
		Flags_4_CarryL_reg <= LCARRYNEW;
		ACarryPrev         <= ACarryOut;
	end
	
	// Arithmetic Carry Input Selector
	//   CS[1:0] = 0	1'b0 (Zero)
	//   CS[1:0] = 1	ACarryPrev (previous cycle carry value [useful for >8bit operations])
	//   CS[1:0] = 2	1'b1 (One)
	//   CS[1:0] = 3	1'b0 (Zero [spare, not currently used])
	assign ACarryIn = CarrySelect1 ? (CarrySelect0 ? 1'b0 : 1'b1) : (CarrySelect0 ? ACarryPrev : 1'b0);
	
	// 8-bit full adder, module defined below.
	full_adder fa ( .a(Shift), .b(Logic), .s(Res), .ci(ACarryIn), .co(ACarryOut) );
	
	// Outputs & tri-stating
	assign MainBus = Alu_Assert ? 8'bZ : Res;
	assign Flags_0_Overflow = ( (Res[7] ^ Shift[7]) & (Res[7] ^ Logic[7]) ); // Overflow checks for valid input combinations - see video 33 for detail
	assign Flags_1_Sign     = Res[7]; // 2's compliment MSB is signed bit.
	assign Flags_2_Zero     = ~|Res; // 8bit NOR
	assign Flags_3_CarryA   = ACarryOut;
	assign Flags_4_CarryL   = Flags_4_CarryL_reg;
	

endmodule

// Verilog Full Adder, inspired by https://www.chipverify.com/verilog/verilog-full-adder
module full_adder (
	input	[7:0]	a,
	input	[7:0]	b,
	input			ci,
	output	[7:0]	s,
	output			co
);
	
	assign {co, s} = a + b + ci;
	
endmodule
