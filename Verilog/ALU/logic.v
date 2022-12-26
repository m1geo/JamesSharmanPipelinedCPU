// -----------------------------------------------------------------------------
// Title   : ALU Logic Unit (ALU/logic.v)
// Create  : Tue 20 Dec 22:31:41 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : Perform ALU logic operations on LHS and/or RHS
//	       : James Sharman design based on Julian Ilett's video
//	       :   https://www.youtube.com/watch?v=15M63Zqkthk
//
//         : Functions provided:
//         :   (LogicSelect=4'b1100) RHS straight through
//         :   (LogicSelect=4'b0011) inverted RHS (for subtraction) 
//         :   (LogicSelect=4'b0000) Zero operation
//         :   (LogicSelect=4'b1111) 255 output
//         :   (LogicSelect=4'b1000) LHS AND RHS
//         :   (LogicSelect=4'b1110) LHS OR RHS
//         :   (LogicSelect=4'b0110) LHS XOR RHS
// -----------------------------------------------------------------------------

module logic_rhs
(
	input        clk,
	input  [3:0] LogicSelect,
    input  [7:0] LHSIn,
    input  [7:0] RHSIn,
    
    output [7:0] RHSOut
);

	// mux outputs 
	wire [7:0] mux_out;
	
	// Loop to unroll the MUXes
	genvar i;
	generate
		for (i = 0; i < 8 ; i = i + 1) begin // for each bit in 8-bit bus
			assign mux_out[i] = RHSIn[i] ? (LHSIn[i] ? LogicSelect[3] : LogicSelect[2]) : (LHSIn[i] ? LogicSelect[1] : LogicSelect[0]);
		end
	endgenerate 

	// registers on the RHS PCB (on control breadboard)
	reg [7:0] reg_da = 0;
	always @ (posedge clk) begin
		reg_da <= mux_out;
	end
	
	assign RHSOut = reg_da; // data out

endmodule //end:logic_rhs
