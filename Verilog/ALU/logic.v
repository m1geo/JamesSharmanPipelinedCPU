// -----------------------------------------------------------------------------
// Title   : ALU Logic Unit (ALU/logic.v)
// Create  : Tue 20 Dec 22:31:41 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : Perform ALU logic operations on LHS or RHS
// -----------------------------------------------------------------------------

module logic
(
	input        clk,
	input  [3:0] LogicSelect,
    input  [7:0] LHSIn,
    input  [7:0] RHSIn,
    
    output [7:0] RHSOut
);

    // code here

endmodule //end:logic
