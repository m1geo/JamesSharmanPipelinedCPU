// -----------------------------------------------------------------------------
// Title   : 8b General Purpose Register (MainBus/reg_8bit.v)
// Create  : Tue 20 Dec 22:32:12 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : 8 bit general purpose register
//         : also used for constant register
// -----------------------------------------------------------------------------

module reg_8bit
(
    input        clk,
    input        reg_load, // active low
    input  [7:0] RegIn,
    
    output [7:0] RegOut
);

    // code here

endmodule //end:reg_8bit
