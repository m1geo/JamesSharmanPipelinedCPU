/*

Name:				ALU Control
Schematic Source:   https://easyeda.com/weirdboyjim/alu-control
Schematic Rev:		1.0 (2020-11-25)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-05-12)

Module notes:
	AluActive is based on non-select0 (i.e., opcode>0).
	Clock is gated by AluActive for AluClock. Clock should not be inverted. BUFGCE is Xilinx Specific.
	OpCode Diode lookup from James.
*/

module ALU_Control (
	input			Clock,

	// ALU IO
    output 			AluClock,
	output			AluActive,
	
	// ALU Control
	output			AC0_RHS0,
	output			AC1_RHS1,
	output			AC2_RHS2,
	output			AC3_RHS3,
	output			AC4_LHS0,
	output			AC5_LHS1,
	output			AC6_CS0,
	output			AC7_CS1,
	
	// ALU OP Input
	input			Pipe1Out_4_ALUOP0,
	input			Pipe1Out_5_ALUOP1,
	input			Pipe1Out_6_ALUOP2,
	input			Pipe1Out_7_ALUOP3
);

	// AluActive inverse of select 0
	wire select0 = ({Pipe1Out_7_ALUOP3, Pipe1Out_6_ALUOP2, Pipe1Out_5_ALUOP1, Pipe1Out_4_ALUOP0} == 4'b0);
	assign AluActive = !select0;

	// clock gate (latch enable on negative clock)
	reg aluclock_enable_flop;
	always @(negedge Clock) aluclock_enable_flop <= AluActive;
	assign AluClock = (Clock & aluclock_enable_flop);

	// ALU Control Diode Matrix
	reg [7:0] diode_matrix;
	always @(Pipe1Out_7_ALUOP3 or Pipe1Out_6_ALUOP2 or Pipe1Out_5_ALUOP1 or Pipe1Out_4_ALUOP0) begin
		case ({Pipe1Out_7_ALUOP3, Pipe1Out_6_ALUOP2, Pipe1Out_5_ALUOP1, Pipe1Out_4_ALUOP0})
			4'd00  : diode_matrix <= 8'h00; // NOP
			4'd01  : diode_matrix <= 8'h10; // SHL
			4'd02  : diode_matrix <= 8'h20; // SHR
			4'd03  : diode_matrix <= 8'h0C; // ADD
			4'd04  : diode_matrix <= 8'h4C; // ADDC
			4'd05  : diode_matrix <= 8'h80; // INC
			4'd06  : diode_matrix <= 8'h40; // INCC
			4'd07  : diode_matrix <= 8'h83; // SUB
			4'd08  : diode_matrix <= 8'h43; // SUBB
			4'd09  : diode_matrix <= 8'h0F; // DEC
			4'd10  : diode_matrix <= 8'h38; // AND
			4'd11  : diode_matrix <= 8'h3E; // OR
			4'd12  : diode_matrix <= 8'h36; // XOR
			4'd13  : diode_matrix <= 8'h33; // NOT
			4'd14  : diode_matrix <= 8'h30; // CLC
			4'd15  : diode_matrix <= 8'h00; // err
		endcase
	end
	
	// outputs - ALU Control
	assign AC0_RHS0 = diode_matrix[0];
	assign AC1_RHS1 = diode_matrix[1];
	assign AC2_RHS2 = diode_matrix[2];
	assign AC3_RHS3 = diode_matrix[3];
	assign AC4_LHS0 = diode_matrix[4];
	assign AC5_LHS1 = diode_matrix[5];
	assign AC6_CS0  = diode_matrix[6];
	assign AC7_CS1  = diode_matrix[7];
	
endmodule