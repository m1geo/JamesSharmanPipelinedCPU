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

    // code here

endmodule //end:flags
