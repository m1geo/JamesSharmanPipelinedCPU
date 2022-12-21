// -----------------------------------------------------------------------------
// Title   : 8-bit Bus Driver MUXes (bus_asserts_8bit.v)
// Create  : Tue 20 Dec 22:46:48 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : MUX to handle which block is driving each 8-bit
//         : Asserts are active low
// -----------------------------------------------------------------------------

module bus_asserts_8bit
(
	// Clock & Reset
    input        clk,
    
    // Input Buses
    input  [7:0] AdderIn,
    input  [7:0] RegA_In,
    input  [7:0] RegB_Main,
    input  [7:0] RegC_Main,
    input  [7:0] RegD_Main,
    input  [7:0] RegConst_Main,
    input  [15:0] TX_Reg, // slice into TXH and TXL internally
    //input  [7:0] RegTXH_Main, 
    //input  [7:0] RegTXL_Main,
    
    // Output Buses
    output [7:0] MainBus,
    output [7:0] LHSBus,
    output [7:0] RHSBus,
    
	// ALU Assert
    input        ALU_Assert_Main,
    
    // 8bit Registers on Main Bus
    input        RegA_Assert_Main,
    input        RegB_Assert_Main,
    input        RegC_Assert_Main,
    input        RegD_Assert_Main,
    input        RegConst_Assert_Main,
    input        RegTXH_Assert_Main,
    input        RegTXL_Assert_Main,
    
    // 8bit Registers on LHS Bus
    input        RegA_Assert_LHS,
    input        RegB_Assert_LHS,
    input        RegC_Assert_LHS,
    input        RegD_Assert_LHS,
    
    // 8bit Registers on RHS Bus
    input        RegA_Assert_RHS,
    input        RegB_Assert_RHS,
    input        RegC_Assert_RHS,
    input        RegD_Assert_RHS
);

	// Main Bus
	assign MainBus = 8'b0;
	
	// LHS Bus
	assign LHSBus = 8'b0;
	
	// RHS Bus
	assign RHSBus = 8'b0;

endmodule //end:bus_asserts_8bit
