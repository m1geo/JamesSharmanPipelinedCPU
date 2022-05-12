/*

Name:				ALU_Control - TESTBENCH

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-05-12)

Module notes:
    Testbench for ALU Control
    The RTL has a bufgce and ANDed AluClock output (based on AluActive). Simulation shows a missing cycle on bufgce but is the right way to clock-gate on FPGA. Likely a weirdness in simulation 'perfection'.
*/

// unimportant timescale.
`timescale 1 ns/10 ps

module tb_ALU_Control();
localparam period = 1000; // period is 1000 nanoseconds (slow because of BUFGCE simulation delay)

reg [3:0] tb_alu_opcode = 0;

reg tb_clk;

wire tb_AluClock_bufgce;
wire tbAluClock_and;
wire tb_AluActive;

wire tb_AC0_RHS0;
wire tb_AC1_RHS1;
wire tb_AC2_RHS2;
wire tb_AC3_RHS3;
wire tb_AC4_LHS0;
wire tb_AC5_LHS1;
wire tb_AC6_CS0;
wire tb_AC7_CS1;


ALU_Control DUT (
	.Clock(tb_clk),
	.Pipe1Out_4_ALUOP0(tb_alu_opcode[0]),
	.Pipe1Out_5_ALUOP1(tb_alu_opcode[1]),
	.Pipe1Out_6_ALUOP2(tb_alu_opcode[2]),
	.Pipe1Out_7_ALUOP3(tb_alu_opcode[3]),
	
	.AluClock_bufgce(tb_AluClock_bufgce),
	.AluClock_and(tbAluClock_and),
	.AluActive(tb_AluActive),
	
	.AC0_RHS0(tb_AC0_RHS0),
	.AC1_RHS1(tb_AC1_RHS1),
	.AC2_RHS2(tb_AC2_RHS2),
	.AC3_RHS3(tb_AC3_RHS3),
	.AC4_LHS0(tb_AC4_LHS0),
	.AC5_LHS1(tb_AC5_LHS1),
	.AC6_CS0(tb_AC6_CS0),
	.AC7_CS1(tb_AC7_CS1)
);

	// generate clock
    always #(period/5) tb_clk=~tb_clk;

    initial begin
		tb_clk = 0;
		
		tb_alu_opcode = 0;
		#period; // wait
		
		tb_alu_opcode = 1;
		#period; // wait
		
		tb_alu_opcode = 2;
		#period; // wait
		
		tb_alu_opcode = 3;
		#period; // wait
		
		tb_alu_opcode = 4;
		#period; // wait
		
		tb_alu_opcode = 5;
		#period; // wait
		
		tb_alu_opcode = 6;
		#period; // wait
		
		tb_alu_opcode = 7;
		#period; // wait
		
		tb_alu_opcode = 8;
		#period; // wait
		
		tb_alu_opcode = 9;
		#period; // wait
		
		tb_alu_opcode = 10;
		#period; // wait
		
		tb_alu_opcode = 11;
		#period; // wait
		
		tb_alu_opcode = 12;
		#period; // wait
		
		tb_alu_opcode = 13;
		#period; // wait
		
		tb_alu_opcode = 14;
		#period; // wait
		
		tb_alu_opcode = 15;
		#period; // wait
	
        $finish;
    end
endmodule // end testbench