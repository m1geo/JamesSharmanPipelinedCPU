// -----------------------------------------------------------------------------
// Title   : Adder (ALU/adder.v)
// Create  : Tue 20 Dec 22:31:34 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : Adder and carry selection
//         : Schematic uses 74283 Adders
// -----------------------------------------------------------------------------

module adder
(
    //input        clk,
    input        CarryFlag,
    input  [7:0] LHS,
    input  [7:0] RHS,
    input        CarrySelectA,
    input        CarrySelectB,
    
    output       CarryOut,
    output [7:0] AdderOut
);

    // CarryFlag Selection
	wire CarrySelected = CarrySelectB ? (CarrySelectA ? 1'b0 : 1'b1) : (CarrySelectA ? CarryFlag : 1'b0);
	
	// Adder Registry (original isn't latched)
	reg [8:0] adder_reg;
	always @ (*) begin
		adder_reg <= {1'b0, LHS} + {1'b0, RHS} + CarrySelected;
	end
	
    assign AdderOut = adder_reg[7:0];
    assign CarryOut = adder_reg[8];
	
endmodule //end:adder
