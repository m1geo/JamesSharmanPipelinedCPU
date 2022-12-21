// -----------------------------------------------------------------------------
// Title   : Pipeline Stage 1 (Pipeline/pipe_stage1.v)
// Create  : Tue 20 Dec 22:32:28 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : Pipeline Stage 1
// -----------------------------------------------------------------------------

module pipe_stage1
(
    input        clk,
    input  [7:0] PipeIn,
    input        BusRequest,
    input        Flag0_Overflow,
    input        Flag1_Sign,
    input        Flag2_Zero,
    input        Flag3_CarryA,
    input        Flag4_CarryL,
    input        Flag5_PCRA_Flip,
    input        Flag6_Reset,
    
    output [7:0] Pipe1Out,
    output       Pipe1Out0_LHS0,
    output       Pipe1Out1_LHS1,
    output       Pipe1Out2_RHS0,
    output       Pipe1Out3_RHS1,
    output       Pipe1Out4_ALUOP0,
    output       Pipe1Out5_ALUOP1,
    output       Pipe1Out6_ALUOP2,
    output       Pipe1Out7_ALUOP3,
    output       Pipe1Out8_XLD0,
    output       Pipe1Out9_XLD1,
    output       Pipe1Out10_XLD2,
    output       Pipe1Out11_XLD03,
    output       Pipe1Out12_XA0,
    output       Pipe1Out13_XA1,
    output       Pipe1Out14_XA2,
    output       Pipe1Out15_FetchSuppress
);

    // code here

endmodule //end:pipe_stage1
