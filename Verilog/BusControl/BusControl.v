/*

Name:				Bus Control
Schematic Source:   https://easyeda.com/weirdboyjim/Bus-Control
Schematic Rev:		1.1 (2019-06-27)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-05-19)

Module notes:
	Video:			https://www.youtube.com/watch?v=B59fb3hpiK8
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
	
	// Register Shared Control Lines
	output 			AddrRegClock,
	output 			AddrRegClear,
	
	// SIL8 PCRA0
	output 			Reg_PCRA0_Dec,
	output 			Reg_PCRA0_Inc,
	output 			Reg_PCRA0_Load,
	output 			Reg_PCRA0_AAddr,
	output 			Reg_PCRA0_AXfer,
	
	// SIL8 PCRA1
	output 			Reg_PCRA1_Dec,
	output 			Reg_PCRA1_Inc,
	output 			Reg_PCRA1_Load,
	output 			Reg_PCRA1_AAddr,
	output 			Reg_PCRA1_AXfer,
	
	// SIL8 SP
	output 			Reg_SP_Dec,
	output 			Reg_SP_Inc,
	output 			Reg_SP_Load,
	output 			Reg_SP_AAddr,
	output 			Reg_SP_AXfer,
	
	// SIL8 SI
	output 			Reg_SI_Dec,
	output 			Reg_SI_Inc,
	output 			Reg_SI_Load,
	output 			Reg_SI_AAddr,
	output 			Reg_SI_AXfer,
	
	// SIL8 DI
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
	output 			Dev9_Load,
	output 			Dev10_Load,
	output 			Dev11_Load,
	output 			Dev12_Load,
	output 			Dev13_Load,
	output 			Dev14_Load,
	
	// SIL8 DEVICEASSERT
	output 			Alu_Assert,
	output 			Dev9_Assert,
	output 			Dev10_Assert,
	output 			Dev11_Assert,
	output 			Dev12_Assert,
	output 			Dev13_Assert,
	output 			Dev14_Assert,
	
	// SIL8 MAINBUSCTRL
	input 	[3:0]	Bus_Assert,
	input 	[3:0]	Bus_Load,
	
	// SIL8 XFERBUSCTRL
	input 	[2:0]	Xfer_Assert,
	input 	[3:0]	XferLoadDec,
	
	// SIL4 INC
	input 	[1:0]	Inc_PCRA,
	input 	[1:0]	Inc_SPSIDI,
	
	// SIL4 ALUSEL
	input 	[1:0]	LHS,
	input 	[1:0]	RHS,
	
	// SIL4 ADDRSEL
	input 	[2:0]	AddrSel,
	
	// SIL4 INPUTS
	input 			Clock_In,
	input 			Reset_In	// active low
);

	// BusControl U1 Inverter
	assign AddrRegClear = ~Reset_In; // AddrRegClear is active high
	assign AddrRegClock = Clock_In; // double inverted in hardware (bad form)
	
	// GPR LHS Decode
	assign {Reg_D_LHS, Reg_C_LHS, Reg_B_LHS, Reg_A_LHS} = ~(1 << LHS); // one cold
	
	// GPR RHS Decode
	assign {Reg_D_RHS, Reg_C_RHS, Reg_B_RHS, Reg_A_RHS} = ~(1 << RHS); // one cold
	
	// Bus Assert Decode (always enabled)
	wire adummy0;
	assign {MemBridge_Assert, Dev14_Assert, Dev13_Assert, Dev12_Assert, Dev11_Assert, 
			Dev10_Assert, Dev9_Assert, Alu_Assert, Reg_TH_Assert, Reg_TL_Assert, 
			Reg_Const_Assert, Reg_D_Assert, Reg_C_Assert, Reg_B_Assert, Reg_A_Assert, adummy0} =  
			~(1 << Bus_Assert); // one cold

	// Bus Load Decode (PCB uses inverted clock on inverted enable.)
	wire ldummy0;
	wire ldummy1;
	assign {MemBridge_Load, Dev14_Load, Dev13_Load, Dev12_Load, Dev11_Load, 
			Dev10_Load, Dev9_Load, ldummy1, Reg_TH_Load, Reg_TL_Load, 
			Reg_Const_LoadBus, Reg_D_Load, Reg_C_Load, Reg_B_Load, Reg_A_Load, ldummy0} =  
			(Clock_In) ? ~(1 << Bus_Load) : 16'hFFFF; // one cold when Clock_In high, else all High.

	// Bus MemBridge Direction - done with a selector on PCB
	assign MemBridge_Direction = ~&Bus_Load; // NAND Bus_Load (when all high, output low)

	// PCRA Decode - PCB has bug where enables left floating
	wire [1:0] pcradummy;
	assign {pcradummy[1:0], Reg_PCRA1_Inc, Reg_PCRA0_Inc} = ~(1 << Inc_PCRA);
	
	// SPSIDI Decode - PCB has bug where enables left floating
	wire spsididummy;
	assign {Reg_DI_Inc, Reg_SI_Inc, Reg_SP_Inc, spsididummy} = ~(1 << Inc_SPSIDI);
	
	// XFER Decode
	wire xferdummy;
	assign {Reg_TX_AMode, Reg_TX_AXfer, Reg_DI_AXfer, Reg_SI_AXfer, Reg_SP_AXfer, 
			Reg_PCRA1_AXfer, Reg_PCRA0_AXfer, xferdummy} = ~(1 << Xfer_Assert);
	
	// ADDRSEL Decode
	wire addrdummy;
	assign {addrdummy, Reg_TX_AAddr, Reg_DI_AAddr, Reg_SI_AAddr, Reg_SP_AAddr, 
			Reg_PCRA1_AAddr, Reg_PCRA0_AAddr, Memory_Ack} = ~(1 << AddrSel);
			
	// XFER LOAD DEC Decode (PCB uses inverted clock on inverted enable.)
	wire [3:0] xflddedeummy;
	assign {xflddedeummy[3:2], Reg_DI_Dec, Reg_SI_Dec, Reg_SP_Dec, Reg_PCRA1_Dec, 
			Reg_PCRA0_Dec, Reg_Const_LoadMem, xflddedeummy[1], Reg_TX_Load, Reg_DI_Load, 
			Reg_SI_Load, Reg_SP_Load, Reg_PCRA1_Load, Reg_PCRA0_Load, xflddedeummy[0]} = 
			(Clock_In) ? ~(1 << XferLoadDec) : 16'hFFFF;
	
endmodule
