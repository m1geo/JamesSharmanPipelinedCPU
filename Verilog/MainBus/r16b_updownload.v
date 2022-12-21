// -----------------------------------------------------------------------------
// Title   : 16b Register (up, down, load) (MainBus/r16b_updownload.v)
// Create  : Tue 20 Dec 22:32:06 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : 16 bit register with up, down and load. For PCRA, SP, SI, DI.
// -----------------------------------------------------------------------------

module r16b_updownload
(
    input         clk,
    input         clear,
    input         reg_load, // active low
    input         inc, // active high
    input         dec, // active high
    input  [15:0] AddrBusIn,
    input  [15:0] XferBusIn,
    
    output [15:0] RegOut,
    output        carry_n,
    output        borrow_n
);

    // code here

endmodule //end:r16b_updownload
