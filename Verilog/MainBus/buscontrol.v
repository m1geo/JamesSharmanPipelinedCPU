// -----------------------------------------------------------------------------
// Title   : Bus Control Logic (MainBus/buscontrol.v)
// Create  : Tue 20 Dec 22:31:50 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : Bus control magic. Clock delayed with Gates will need fixing. See schematics!
// -----------------------------------------------------------------------------

module buscontrol
(
	// Inputs
    input        clk,
    input        reset_in,
    input        MainBus_Assert0,
    input        MainBus_Assert1,
    input        MainBus_Assert2,
    input        MainBus_Assert3,
    input        MainBus_Load0,
    input        MainBus_Load1,
    input        MainBus_Load2,
    input        MainBus_Load3,
    input        Inc_SPSIDI0,
    input        Inc_SPSIDI1,
    input        AddrSel0,
    input        AddrSel1,
    input        AddrSel2,
    input        LHS0,
    input        LHS1,
    input        RHS0,
    input        RHS1,
    input        Xfer_Assert0,
    input        Xfer_Assert1,
    input        Xfer_Assert2,
    input        Xfer_LoadDec0,
    input        Xfer_LoadDec1,
    input        Xfer_LoadDec2,
    input        Xfer_LoadDec3,
    input        Inc_PCRA0,
    input        Inc_PCRA1,

	// Outputs
    output       Reg_A_LHS,
    output       Reg_B_LHS,
    output       Reg_C_LHS,
    output       Reg_D_LHS,
    output       Reg_A_RHS,
    output       Reg_B_RHS,
    output       Reg_C_RHS,
    output       Reg_D_RHS,
    output       Reg_A_Assert,
    output       Reg_B_Assert,
    output       Reg_C_Assert,
    output       Reg_D_Assert,
    output       Reg_Const_Assert,
    output       Reg_TL_Assert,
    output       Reg_TH_Assert,
    output       Reg_A_Load,
    output       Reg_B_Load,
    output       Reg_C_Load,
    output       Reg_D_Load,
    output       Reg_TL_Load,
    output       Reg_TH_Load,
    output       MemBridge_Load,
    output       MemBridge_Direction,
    output       PCRA0_Inc,
    output       PCRA0_AssertXfer,
    output       PCRA0_LoadXfer,
    output       PCRA0_Dec,
    output       PCRA0_AssertAddr,
    output       PCRA1_Inc,
    output       PCRA1_AssertXfer,
    output       PCRA1_LoadXfer,
    output       PCRA1_Dec,
    output       PCRA1_AssertAddr,
    output       SP_Inc,
    output       SP_AssertXfer,
    output       SP_LoadXfer,
    output       SP_AssertAddr,
    output       SP_Dec,
    output       SI_Inc,
    output       SI_AssertXfer,
    output       SI_LoadXfer,
    output       SI_AssertAddr,
    output       SI_Dec,
    output       DI_Inc,
    output       DI_AssertXfer,
    output       DI_LoadXfer,
    output       DI_AssertAddr,
    output       DI_Dec,
    output       MemBridge_Assert,
    output       Reg_Const_Load,
    output       ALU_Assert,
    output       TX_AssertXfer,
    output       TX_AssertAddr,
    output       TX_LoadXfer,
    output       TX_AssertMode,
    
    // Unused
    output       ALU_Load,
    output       Memory_Ack,
    output       Dev9_Assert,
    output       Dev10_Assert,
    output       Dev11_Assert,
    output       Dev12_Assert,
    output       Dev13_Assert,
    output       Dev14_Assert,
    output       Dev9_Load,
    output       Dev10_Load,
    output       Dev11_Load,
    output       Dev12_Load,
    output       Dev13_Load,
    output       Dev14_Load
);

    // code here

endmodule //end:buscontrol
