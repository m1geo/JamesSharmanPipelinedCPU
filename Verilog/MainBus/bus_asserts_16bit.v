// -----------------------------------------------------------------------------
// Title   : 16-bit Bus Driver MUXes (bus_asserts_16bit.v)
// Create  : Wed 21 Dec 00:52:16 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : MUX to handle which block is driving each 16-bit
//         : Asserts are active low
// -----------------------------------------------------------------------------

module bus_asserts_16bit
(
	// Clock & Reset
    input        clk,
    
    // Input Buses
    input  [15:0] PCRA0_Reg,
    input  [15:0] PCRA1_Reg,
    input  [15:0] SP_Reg,
    input  [15:0] SI_Reg,
    input  [15:0] DI_Reg,
    input  [15:0] TX_Reg,
    
    // Output Buses
    output [15:0] AddrBus,
    output [15:0] XferBus,
    
    // Address Asserts
    input         PCRA0_Reg_Assert_Addr,
    input         PCRA1_Reg_Assert_Addr,
    input         SP_Reg_Assert_Addr,
    input         SI_Reg_Assert_Addr,
    input         DI_Reg_Assert_Addr,
    input         TX_Reg_Assert_Addr,

    // Transfer Asserts
    input         PCRA0_Reg_Assert_Xfer,
    input         PCRA1_Reg_Assert_Xfer,
    input         SP_Reg_Assert_Xfer,
    input         SI_Reg_Assert_Xfer,
    input         DI_Reg_Assert_Xfer,
    input         TX_Reg_Assert_Xfer
);

	// Address Bus
	assign AddrBus = 16'b0;
	
	// Transfer Bus
	assign XferBus = 16'b0;
	
endmodule //end:bus_asserts_16bit
