// -----------------------------------------------------------------------------
// Title   : Pipeline Stage 0 (Pipeline/pipe_stage0.v)
// Create  : Tue 20 Dec 22:32:25 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : Pipeline Stage 0
// -----------------------------------------------------------------------------

module pipe_stage0
(
    input        clk,
    input  [7:0] MemData,
    input        BusRequest,
    input        FetchSuppress,
    input        Flag5_PCRA_Flip,
    
    output [7:0] Pipe0Out,
    output       Pipe0Out0_IncPCRA0,
    output       Pipe0Out1_IncPCRA1
);

    // code here

endmodule //end:pipe_stage0
