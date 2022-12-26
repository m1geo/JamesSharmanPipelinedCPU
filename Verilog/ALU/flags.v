// -----------------------------------------------------------------------------
// Title   : FLAGS (ALU/flags.v)
// Create  : Tue 20 Dec 22:31:37 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : ALU flag generation
// -----------------------------------------------------------------------------

module flags
(
	input        clk,
	input        ArithCarryIn,
	input        LogicCarryIn,
    input  [7:0] DataIn,
    input  [7:0] LHSIn,
    input  [7:0] RHSIn,
    input        CarrySelectA,
    input        CarrySelectB,
    
    output       ArithCarryFlag,
    output       LogicCarryFlag,
    output       ZeroFlag,
    output       SignFlag,
    output       OverflowFlag,
    output       CarrySelectADelayed,
    output       CarrySelectBDelayed
);

	// Overflow - registered below
	wire Overflow = ((LHSIn[7] ^ DataIn[7]) & (DataIn[7] ^ RHSIn[7]));
	
	// Zero Flag - unregistered
	assign ZeroFlag = ~(| DataIn); // NOR

    // Register Values
    reg regCarrySelectA = 0;
    reg regCarrySelectB = 0;
    reg regOverflow = 0;
    reg regSign = 0;
    reg regArithCarry = 0;
    reg regLogicCarry = 0;
    
	always @ (posedge clk) begin
    	regCarrySelectA <= CarrySelectA;
    	regCarrySelectB <= CarrySelectB;
    	regOverflow <= Overflow;
    	regSign <= DataIn[7];
    	regArithCarry <= ArithCarryIn;
    	regLogicCarry <= LogicCarryIn;
	end
	
	assign CarrySelectADelayed = regCarrySelectA;
	assign CarrySelectBDelayed = regCarrySelectB;
	assign OverflowFlag = regOverflow;
	assign SignFlag = regSign;
	assign ArithCarryFlag = regArithCarry;
	assign LogicCarryFlag = regLogicCarry;

endmodule //end:flags
