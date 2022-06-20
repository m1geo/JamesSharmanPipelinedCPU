/*
Name:				Entire CPU - DRAFT - ATTEMPT1

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		0.1 (2022-06-17)

Module notes:
*/

///////////////////////////////////////////////////////////////////////////////
// INCLUDE VERILOG SUB MODULES

`include "ALU/ALU.v"
`include "BusControl/BusControl.v"
`include "ConstantRegisterV2/ConstantRegisterV2.v"
`include "CounterAddressRegister/CAR_Group.v"
`include "GeneralPurposeRegister/GPR_Group.v"
`include "MainMemory/MainMemory3232.v"
`include "MemBridge/MemBridge.v"
`include "Pipeline/Pipeline.v"
`include "TransferRegister/TransferRegisterV1.v"
`include "UART/UART.v" // not written yet


///////////////////////////////////////////////////////////////////////////////
// Inter-module Signals & Buses

// Buses
wire  [7:0] MAINBUS; // Data bus
wire  [7:0] MEMDATA; // Memory data bus
wire  [7:0] LHSBUS;  // GPR-ALU-Left bus
wire  [7:0] RHSBUS;  // GPR-ALU-Right bus
wire [15:0] ADDRBUS; // Address Bus (16bit)
wire [15:0] XFERBUS; // Transfer Bus (16bit)
wire  [6:0] FLAGS;   // Flags Bus ()

Flags_0_Overflow
Flags_1_Sign
Flags_2_Zero
Flags_3_CarryA
Flags_4_CarryL
Flags_5_PCRA_Flip
Flags_6_Reset

// Signals
wire        MAINCLK; // Master system clock
wire        MAINRST; // Master system reset


///////////////////////////////////////////////////////////////////////////////
// ALU Top

ALU alu (
	// Clock (input)
	.Clock(MAINCLK),
	
	// MAINBUS (inout)
	.MainBus(MAINBUS), // [7:0]
	
	// GPR ALU BUSES (inputs)
	.LHS(LHSBUS), // [7:0]
	.RHS(RHSBUS), // [7:0]
	
	// ALU OP (inputs)
	.Pipe1Out_4_ALUOP0(),
	.Pipe1Out_5_ALUOP1(),
	.Pipe1Out_6_ALUOP2(),
	.Pipe1Out_7_ALUOP3(),
	
	// FLAGS (outputs)
	.Flags_0_Overflow(),
	.Flags_1_Sign(),
	.Flags_2_Zero(),
	.Flags_3_CarryA(),
	.Flags_4_CarryL(),

	// CARRYCTRL (inputs)
	.LCarryIn(),
	.LCARRYNEW(),
	.Alu_Assert()
);


///////////////////////////////////////////////////////////////////////////////
// Bus Control

BusControl buscontrol (
	// SIL4 INPUTS
	.Clock_In(MAINCLK),
	.Reset_In(MAINRST),	// active low
	
	// SIL8 MAINBUSCTRL
	.Bus_Assert(), // [3:0]
	.Bus_Load(), // [3:0]
	
	// SIL8 XFERBUSCTRL
	.Xfer_Assert(), // [2:0]
	.XferLoadDec(), // [3:0]
	
	// SIL4 INC
	.Inc_PCRA(), // [1:0]
	.Inc_SPSIDI(), // [1:0]
	
	// SIL4 ALUSEL
	.LHS(), // [1:0] (not LHSBUS)
	.RHS(), // [1:0] (not RHSBUS)
	
	// SIL4 ADDRSEL
	.AddrSel(), // [2:0]
		
	// SIL5 A (outputs)
	.Reg_A_Load(),
	.Reg_A_Assert(),
	.Reg_A_LHS(),
	.Reg_A_RHS(),
	
	// SIL5 B (outputs)
	.Reg_B_Load(),
	.Reg_B_Assert(),
	.Reg_B_LHS(),
	.Reg_B_RHS(),
	
	// SIL5 C (outputs)
	.Reg_C_Load(),
	.Reg_C_Assert(),
	.Reg_C_LHS(),
	.Reg_C_RHS(),
	
	// SIL5 D (outputs)
	.Reg_D_Load(),
	.Reg_D_Assert(),
	.Reg_D_LHS(),
	.Reg_D_RHS(),

	// SIL4 CONST (outputs)
	.Reg_Const_LoadBus(),
	.Reg_Const_LoadMem(),
	.Reg_Const_Assert(),
	
	// Register Shared Control Lines (outputs) - one per connector on PCBs
	.AddrRegClock(),
	.AddrRegClear(),
	
	// SIL8 PCRA0 (outputs)
	.Reg_PCRA0_Dec(),
	.Reg_PCRA0_Inc(),
	.Reg_PCRA0_Load(),
	.Reg_PCRA0_AAddr(),
	.Reg_PCRA0_AXfer(),
	
	// SIL8 PCRA1 (outputs)
	.Reg_PCRA1_Dec(),
	.Reg_PCRA1_Inc(),
	.Reg_PCRA1_Load(),
	.Reg_PCRA1_AAddr(),
	.Reg_PCRA1_AXfer(),
	
	// SIL8 SP (outputs)
	.Reg_SP_Dec(),
	.Reg_SP_Inc(),
	.Reg_SP_Load(),
	.Reg_SP_AAddr(),
	.Reg_SP_AXfer(),
	
	// SIL8 SI (outputs)
	.Reg_SI_Dec(),
	.Reg_SI_Inc(),
	.Reg_SI_Load(),
	.Reg_SI_AAddr(),
	.Reg_SI_AXfer(),
	
	// SIL8 DI (outputs)
	.Reg_DI_Dec(),
	.Reg_DI_Inc(),
	.Reg_DI_Load(),
	.Reg_DI_AAddr(),
	.Reg_DI_AXfer(),
	
	// SIL9 XFER (outputs)
	.Reg_TL_Load(),
	.Reg_TL_Assert(),
	.Reg_TH_Load(),
	.Reg_TH_Assert(),
	.Reg_TX_Load(),
	.Reg_TX_AAddr(),
	.Reg_TX_AXfer(),
	.Reg_TX_AMode(),
	
	// SIL5 MEM (outputs)
	.MemBridge_Assert(),
	.MemBridge_Load(),
	.MemBridge_Direction(),
	.Memory_Ack(),
	
	// SIL8 DEVICELOAD (outputs)
	.Dev9_Load(),
	.Dev10_Load(),
	.Dev11_Load(),
	.Dev12_Load(),
	.Dev13_Load(),
	.Dev14_Load(),
	
	// SIL8 DEVICEASSERT (outputs)
	.Alu_Assert(),
	.Dev9_Assert(),
	.Dev10_Assert(),
	.Dev11_Assert(),
	.Dev12_Assert(),
	.Dev13_Assert(),
	.Dev14_Assert()
);


///////////////////////////////////////////////////////////////////////////////
// Constant Register

ConstantRegisterV2 constantregister (
	.MemData(MEMDATA),
	.MainBus(MAINBUS),
	.a_main_n(),
	.load()
);


///////////////////////////////////////////////////////////////////////////////
// Counter Address Register Group

CAR_Group cargroup (
	.Addr(), // io [15:0]
	.Xbus(), // io [15:0]
	.clock(MAINCLK), // in
	.clear(), // in
	
	// PCRA0 (inputs)
	.pcra0_dec(),
	.pcra0_inc(),
	.pcra0_xbus_load(),
	.pcra0_xbus_assert(),
	.pcra0_addr_assert(),
	
	// PCRA1 (inputs)
	.pcra1_dec(),
	.pcra1_inc(),
	.pcra1_xbus_load(),
	.pcra1_xbus_assert(),
	.pcra1_addr_assert(),
	
	// SP (inputs)
	.sp_dec(),
	.sp_inc(),
	.sp_xbus_load(),
	.sp_xbus_assert(),
	.sp_addr_assert(),
	
	// SI (inputs)
	.si_dec(),
	.si_inc(),
	.si_xbus_load(),
	.si_xbus_assert(),
	.si_addr_assert(),
	
	// DI (inputs)
	.di_dec(),
	.di_inc(),
	.di_xbus_load(),
	.di_xbus_assert(),
	.di_addr_assert()
);


///////////////////////////////////////////////////////////////////////////////
// General Purpose Register Group

GPR_Group gprgroup (
	.MainBus(MAINBUS), //io
	.LHSBus(LHSBUS), // out
	.RHSBus(RHSBUS), // out

	// GPR A (inputs)
	.a_load(),
	.a_main_assert(),
	.a_lhs_assert(),
	.a_rhs_assert(),
	
	// GPR B (inputs)
	.b_load(),
	.b_main_assert(),
	.b_lhs_assert(),
	.b_rhs_assert(),
	
	// GPR C (inputs)
	.c_load(),
	.c_main_assert(),
	.c_lhs_assert(),
	.c_rhs_assert(),
	
	// GPR D (inputs)
	.d_load(),
	.d_main_assert(),
	.d_lhs_assert(),
	.d_rhs_assert()
);


///////////////////////////////////////////////////////////////////////////////
// Main Memories (RAM and ROM)

MainMemory3232 mainmemory3232 (
	.Addr(ADDRBUS), // in [15:0]
	.MEMDATA(MEMDATA), // inout [7:0]
	
	// Mem Inputs
	.MemBridge_Load(),
	.MemBridge_Direction() // high = memory module output
);


///////////////////////////////////////////////////////////////////////////////
// Memory Bridge

MemBridge membridge (
	.MainBus(MAINBUS),
	.MemData(MEMDATA),
	
	.a_membridge_n(),	// active low, MemData->MainBus
	.d_membridge_n()	// active low, MainBus->MemData
);


///////////////////////////////////////////////////////////////////////////////
// Pipeline (check FetchSurpress & BusRequest when Synthesising)

Pipeline pipeline (
	.ClockIn(MAINCLK), // in
	.MEMDATA(MEMDATA), // in
	.PipeOut(), // out (not used)
		
	// Control (outputs)
	.Pipe0Out(), // [1:0]
	.Pipe1Out(), // [15:0]
	.Pipe2Out(), // [15:0]
	
	// flag (inputs)
	.Flags() // [6:0]
);


///////////////////////////////////////////////////////////////////////////////
// Transfer Register

TransferRegisterV1 transferregister (
	.Addr(),
	.Bus(),
	.MainBus(),
	.a_tl_n(),
	.l_tl_n(),
	.a_th_n(),
	.l_th_n(),
	.l_tx_n(),
	.a_tx_addr_n(),
	.a_tx_xfer_n()
);


// End