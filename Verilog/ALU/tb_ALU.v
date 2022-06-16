/*

Name:				ALU - TESTBENCH

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-05-16)

Module notes:
    Testbench for ALU
*/

// unimportant timescale.
`timescale 100 ns/10 ns

module tb_ALU();
localparam period = 10; // period is 1 microseconds

reg       tb_clk;
reg [3:0] tb_alu_opcode = 0;
reg [7:0] tb_LHS = 0;
reg [7:0] tb_RHS = 0;
reg       tb_Alu_Assert = 0;
reg       tb_LCarryNew = 0;
reg       tb_LCarryIn = 0;

wire [7:0] tb_MainBus;
wire       tb_Flags_0_Overflow;
wire       tb_Flags_1_Sign;
wire       tb_Flags_2_Zero;
wire       tb_Flags_3_CarryA;
wire       tb_Flags_4_CarryL;

ALU DUT (
	// Clock (input)
	.Clock(tb_clk),
	
	// MAINBUS (inout)
	.MainBus(tb_MainBus), // [7:0]
	
	// GPR ALU BUSES (inputs)
	.LHS(tb_LHS), // [7:0]
	.RHS(tb_RHS), // [7:0]
	
	// ALU OP (inputs)
	.Pipe1Out_4_ALUOP0(tb_alu_opcode[0]),
	.Pipe1Out_5_ALUOP1(tb_alu_opcode[1]),
	.Pipe1Out_6_ALUOP2(tb_alu_opcode[2]),
	.Pipe1Out_7_ALUOP3(tb_alu_opcode[3]),
	
	// FLAGS (outputs)
	.Flags_0_Overflow(tb_Flags_0_Overflow),
	.Flags_1_Sign(tb_Flags_1_Sign),
	.Flags_2_Zero(tb_Flags_2_Zero),
	.Flags_3_CarryA(tb_Flags_3_CarryA),
	.Flags_4_CarryL(tb_Flags_4_CarryL),

	// CARRYCTRL (inputs)
	.LCarryIn(tb_LCarryIn),
	.LCARRYNEW(tb_LCarryNew),
	.Alu_Assert(tb_Alu_Assert)
);

	// generate clock
    always #(period/5) tb_clk=~tb_clk;

    integer i;

    initial begin
		tb_alu_opcode = 1;
		tb_LHS = 4;
		tb_RHS = 3;
		tb_clk = 1;
		#1
		tb_clk = 0;
		#1
		tb_clk = 1;
		#1
		tb_clk = 0;

		// test loads & asserts
		for (i=0; i<64; i=i+1) begin
		    tb_alu_opcode = i[3:0];
		    tb_LCarryIn = i[4];
		    tb_LCarryNew = i[5];
			#(period);
		end
			
        $finish;
    end
endmodule // end testbench