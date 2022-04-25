/*

Name:				Bus Control
Schematic Source:   https://easyeda.com/weirdboyjim/Bus-Control
Schematic Rev:		1.1 (2019-04-20)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
	Just an empty module with ports.
	
*/

module BusControl (
	
	// SIL5 A
	output 			Reg_A_Load,
	output 			Reg_A_Assert,
	output 			Reg_A_LHS,
	output 			Reg_A_RHS,
	
	// SIL5 B
	output 			Reg_B_Load,
	output 			Reg_B_Assert,
	output 			Reg_B_LHS,
	output 			Reg_B_RHS,
	
	// SIL5 C
	output 			Reg_C_Load,
	output 			Reg_C_Assert,
	output 			Reg_C_LHS,
	output 			Reg_C_RHS,
	
	// SIL5 D
	output 			Reg_D_Load,
	output 			Reg_D_Assert,
	output 			Reg_D_LHS,
	output 			Reg_D_RHS,

	// SIL4 CONST
	output 			Reg_Const_LoadBus,
	output 			Reg_Const_LoadMem,
	output 			Reg_Const_Assert,
	
	// SIL8 PCRA0
	output 			AddrRegClock,
	output 			AddrRegClear,
	output 			Reg_PCRA0_Dec,
	output 			Reg_PCRA0_Inc,
	output 			Reg_PCRA0_Load,
	output 			Reg_PCRA0_AAddr,
	output 			Reg_PCRA0_AXfer,
	
	// SIL8 PCRA1
	output 			AddrRegClock,
	output 			AddrRegClear,
	output 			Reg_PCRA1_Dec,
	output 			Reg_PCRA1_Inc,
	output 			Reg_PCRA1_Load,
	output 			Reg_PCRA1_AAddr,
	output 			Reg_PCRA1_AXfer,
	
	// SIL8 SP
	output 			AddrRegClock,
	output 			AddrRegClear,
	output 			Reg_SP_Dec,
	output 			Reg_SP_Inc,
	output 			Reg_SP_Load,
	output 			Reg_SP_AAddr,
	output 			Reg_SP_AXfer,
	
	// SIL8 SI
	output 			AddrRegClock,
	output 			AddrRegClear,
	output 			Reg_SI_Dec,
	output 			Reg_SI_Inc,
	output 			Reg_SI_Load,
	output 			Reg_SI_AAddr,
	output 			Reg_SI_AXfer,
	
	// SIL8 DI
	output 			AddrRegClock,
	output 			AddrRegClear,
	output 			Reg_DI_Dec,
	output 			Reg_DI_Inc,
	output 			Reg_DI_Load,
	output 			Reg_DI_AAddr,
	output 			Reg_DI_AXfer,
	
	// SIL9 XFER
	output 			Reg_TL_Load,
	output 			Reg_TL_Assert,
	output 			Reg_TH_Load,
	output 			Reg_TH_Assert,
	output 			Reg_TX_Load,
	output 			Reg_TX_AAddr,
	output 			Reg_TX_AXfer,
	output 			Reg_TX_AMode,
	
	// SIL5 MEM
	output			MemBridge_Assert,
	output			MemBridge_Load,
	output			MemBridge_Direction,
	output			Memory_Ack,
	
	
	// SIL8 DEVICELOAD
	wire 			Dev9_Load,
	wire 			Dev10_Load,
	wire 			Dev11_Load,
	wire 			Dev12_Load,
	wire 			Dev13_Load,
	wire 			Dev14_Load,
	
	// SIL8 DEVICEASSERT
	output 			Alu_Assert,
	output 			Dev9_Assert,
	output 			Dev10_Assert,
	output 			Dev11_Assert,
	output 			Dev12_Assert,
	output 			Dev13_Assert,
	output 			Dev14_Assert,
	
	// SIL8 MAINBUSCTRL
	input 			Bus_Assert0,
	input 			Bus_Assert1,
	input 			Bus_Assert2,
	input 			Bus_Assert3,
	input 			Bus_Load0,
	input 			Bus_Load1,
	input 			Bus_Load2,
	input 			Bus_Load3,
	
	// SIL8 XFERBUSCTRL
	input 			Xfer_Assert0,
	input 			Xfer_Assert1,
	input 			Xfer_Assert2,
	input 			XferLoadDec0,
	input 			XferLoadDec1,
	input 			XferLoadDec2,
	input 			XferLoadDec3,
	
	// SIL4 INC
	input 			Inc_PCRA_0,
	input 			Inc_PCRA_1,
	input 			Inc_SPSIDI_0,
	input 			Inc_SPSIDI_1,
	
	// SIL4 ALUSEL
	input 			LHS_0,
	input 			LHS_1,
	input 			RHS_0,
	input 			RHS_1,
	
	// SIL4 ADDRSEL
	input 			AddrSel0,
	input 			AddrSel1, 
	input 			AddrSel2,
	
	// SIL4 INPUTS
	input 			Clock_In,
	input 			Reset_In
);

	// main code goes here!

endmodule