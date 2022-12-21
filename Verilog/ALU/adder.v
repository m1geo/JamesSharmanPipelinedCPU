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
// -----------------------------------------------------------------------------

module adder
(
    input        clk,
    input        CarryFlag,
    input  [7:0] LHS,
    input  [7:0] RHS,
    input        CarrySelectA,
    input        CarrySelectB,
    
    output       CarryOut,
    output [7:0] AdderOut
);

    // code here

endmodule //end:adder
