// -----------------------------------------------------------------------------
// Title   : Memory (RAM & ROM) (MainBus/memory.v)
// Create  : Tue 20 Dec 22:32:02 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : Combined RAM+ROM to use BRAM in FPGA
//         : There's some magic in here. Check the schematics carefully.
//         : 
//         : MemBridge_Assert is /OE for MainBus Bus
//         : MemBridge_Direction is /OE for MemData Bus
//         :  \=> also drives /OE for RAM/ROM ICs onto MemData Bus
// -----------------------------------------------------------------------------

module memory
(
	input         clk,
    input  [15:0] AddrBus,
    input   [7:0] MemDataIn,
    input   [7:0] MainBusIn,
    input         MemBridge_Dir, // check what this does, and if it should be in the 8bit MUXes.
    input         MemBridge_Load, // active low
    input         MemBridge_Assert, // check what this does, and if it should be in the 8bit MUXes.
    
    output  [7:0] MemDataOut,
    output  [7:0] MainBusOut
);

    // code here

endmodule //end:memory
