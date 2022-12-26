// -----------------------------------------------------------------------------
// Title   : ALU Shift Unit (ALU/shift.v)
// Create  : Tue 20 Dec 22:31:48 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : Perform ALU shift operations on LHS 
// -----------------------------------------------------------------------------

module shift_lhs
(
	input        clk,
	input        SelectA,
	input        SelectB,
	input        CarryIn,
    input  [7:0] LHSIn,
    
    output       CarryOut,
    output [7:0] LHSOut
);

    wire CarrySelected = CarrySelectB ? (CarrySelectA ? 1'b0 : 1'b1) : (CarrySelectA ? CarryFlag : 1'b0);
	
	// C0 (unchanged)
	wire [7:0] C0_da = LHSIn;
	wire       C0_co = 1'b0; // PCB Jumper "NC_CIr" (fitted in Video2 21:22)
	//wire       C0_co = CarryIn; // PCB Jumper "NC_CIn"

	// C1 (shift left <--)
	wire [7:0] C1_da  = {LHSIn[6:0], CarryIn};
	wire       C1_co  = LHSIn[7];

	// C2 (shift right-->)
	wire [7:0] C2_da  = {CarryIn, LHSIn[7:1]};
	wire       C2_co  = LHSIn[0];

	// C3 (zero)
	wire [7:0] C3_da = 8'b0;
	wire       C3_co = 1'b0;

	// The MUX
	wire [7:0] mux_da;
	wire       mux_co;
	
	// mux the 4 different states.
	assign mux_da = SelectB ? (SelectA ? C3_da : C2_da) : (SelectA ? C1_da : C0_da);
	assign mux_co = SelectB ? (SelectA ? C3_co : C2_co) : (SelectA ? C1_co : C0_co);
	
	// registers on the LHS PCB (on control breadboard)
	reg [7:0] reg_da = 0;
	reg       reg_co = 0;
	always @ (posedge clk) begin
		reg_da <= mux_da;
		reg_co <= mux_co;
	end
	
	assign LHSOut = reg_da; // data out
	assign CarryOut = reg_co; // carry out

endmodule //end:shift_lhs
