// -----------------------------------------------------------------------------
// Title   : Pipeline Stage 2 (Pipeline/pipe_stage2.v)
// Create  : Tue 20 Dec 22:32:32 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : Pipeline Stage 2
// -----------------------------------------------------------------------------

module pipe_stage2
(
    input        clk,
    input  [7:0] PipeIn,
    input        Flag0_Overflow,
    input        Flag1_Sign,
    input        Flag2_Zero,
    input        Flag3_CarryA,
    input        Flag4_CarryL,
    input        Flag5_PCRA_Flip,
    input        Flag6_Reset,
    
    output [7:0] Pipe2Out,
    output       Pipe2Out0_MA0, // main bus asserts
    output       Pipe2Out1_MA1,
    output       Pipe2Out2_MA2,
    output       Pipe2Out3_MA3,
    output       Pipe2Out4_ML0, // main bus loads
    output       Pipe2Out5_ML1,
    output       Pipe2Out6_ML2,
    output       Pipe2Out7_ML3,
    output       Pipe2Out8_Inc0,
    output       Pipe2Out9_Inc1,
    output       Pipe2Out10_Addr0,
    output       Pipe2Out11_Addr1,
    output       Pipe2Out12_Addr2,
    output       Pipe2Out13_BusRequest,
    output       Pipe2Out14_PCRA_Flip,
    output       Pipe2Out15_Break
);

    // code here

endmodule //end:pipe_stage2
