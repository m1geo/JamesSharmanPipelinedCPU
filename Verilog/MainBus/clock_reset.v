// -----------------------------------------------------------------------------
// Title   : Clock & Reset Logic (MainBus/clock_reset.v)
// Create  : Tue 20 Dec 22:31:57 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : Reset_In is active low. May need fast-clock and half-clock?
//         : Reset holds a few times while clock runs to clear the pipeline.
// -----------------------------------------------------------------------------

module clock_reset
(
    input        clk,
    input        reset_in,
    output       reset_out_p,
    output       reset_out_n
);

    // code here

endmodule //end:clock_reset

