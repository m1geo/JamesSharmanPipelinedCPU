/*
Name:				Entire CPU - ATTEMPT1

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		0.1 (2022-06-30)

Module notes:
	jamon's jamessharman-8bit-cpu-sim project has a diagram of interconnects
	https://raw.githubusercontent.com/jamon/jamessharman-8bit-cpu-sim/main/Cpu.svg
	
	Should probably bundle the GPRx and CARx control lines into buses.
	
	Check ALU carries are correct - LCARRYNEW is likely logic carry = flag4
	  See alu.LCarryIn(...) - Flag3 or Flag4?
*/

///////////////////////////////////////////////////////////////////////////////
// INCLUDE VERILOG SUB MODULES

`include "ALU/ALU.v"
`include "BusControl/BusControl.v"
`include "ConstantRegisterV2/ConstantRegisterV2.v"
`include "CounterAddressRegister/CAR_Group.v"
`include "GeneralPurposeRegister/GPR_Group.v"
`include "MainMemory/MainMemory64Shadow.v"
`include "MemBridge/MemBridge.v"
`include "Pipeline/Pipeline.v"
`include "TransferRegister/TransferRegisterV1.v"
//`include "UART/UART.v" // not written yet

module CPU (
    input        MAINCLK, // Master system clock
    input        MAINRST, // Master system reset (active low)
    output       w_mem_debugerror,
    output       MAINBUS,
    output       MEMDATA,
    output       ADDRBUS
);
    
    ///////////////////////////////////////////////////////////////////////////////
    // Inter-module Signals & Buses
    
    // Buses
    wire  [7:0] MAINBUS;  // Data bus
    wire  [7:0] MEMDATA;  // Memory data bus
    wire  [7:0] LHSBUS;   // GPR-ALU-Left bus
    wire  [7:0] RHSBUS;   // GPR-ALU-Right bus
    wire [15:0] ADDRBUS;  // Address Bus (16bit)
    wire [15:0] XFERBUS;  // Transfer Bus (16bit)
    wire  [1:0] PIPE0OUT; // Pipeline Stage 1 Output Bus (2bit)
    wire [15:0] PIPE1OUT; // Pipeline Stage 1 Output Bus (16bit)
    wire [15:0] PIPE2OUT; // Pipeline Stage 1 Output Bus (16bit)
    wire  [1:0] ALULHS;   // LHS bus
    wire  [1:0] ALURHS;   // RHS bus
    
    wire  [6:0] FLAGS;   // Flags Bus (6_Reset, 5_PCRA_Flip, 4_CarryL, 3_CarryA, 2_Zero, 1_Sign, 0_Overflow)
    
    // Signals
    //wire        MAINCLK; // Master system clock
    //wire        MAINRST; // Master system reset (active low)
    
    // GPR Regs
    wire w_a_load;
    wire w_a_main_assert;
    wire w_a_lhs_assert;
    wire w_a_rhs_assert;
    
    wire w_b_load;
    wire w_b_main_assert;
    wire w_b_lhs_assert;
    wire w_b_rhs_assert;
    
    wire w_c_load;
    wire w_c_main_assert;
    wire w_c_lhs_assert;
    wire w_c_rhs_assert;
    
    wire w_d_load;
    wire w_d_main_assert;
    wire w_d_lhs_assert;
    wire w_d_rhs_assert;
    
    // CAR Regs
    wire w_reg_pcra0_dec;
    wire w_reg_pcra0_inc;
    wire w_reg_pcra0_load;
    wire w_reg_pcra0_aaddr;
    wire w_reg_pcra0_axfer;
    
    wire w_reg_pcra1_dec;
    wire w_reg_pcra1_inc;
    wire w_reg_pcra1_load;
    wire w_reg_pcra1_aaddr;
    wire w_reg_pcra1_axfer;
    
    wire w_reg_sp_dec;
    wire w_reg_sp_inc;
    wire w_reg_sp_load;
    wire w_reg_sp_aaddr;
    wire w_reg_sp_axfer;
    
    wire w_reg_si_dec;
    wire w_reg_si_inc;
    wire w_reg_si_load;
    wire w_reg_si_aaddr;
    wire w_reg_si_axfer;
    
    wire w_reg_di_dec;
    wire w_reg_di_inc;
    wire w_reg_di_load;
    wire w_reg_di_aaddr;
    wire w_reg_di_axfer;
    
    // Transfer Reg
    wire w_reg_tl_load;
    wire w_reg_tl_assert;
    wire w_reg_th_load;
    wire w_reg_th_assert;
    wire w_reg_tx_load;
    wire w_reg_tx_aaddr;
    wire w_reg_tx_axfer;
    
    // Const Reg
    wire w_const_a_main_n;
    wire w_const_load_n;
    
    // Memory Control
    wire w_mem_direction;
    wire w_mem_load;
    wire w_mem_assert;
    wire w_mem_ack;
    //wire w_mem_debugerror; // top level output
    
    // Address Registers
    wire w_addrreg_clk;
    wire w_addrreg_rst;
    
    // ALU Control
    wire w_alu_assert;
    
    
    ///////////////////////////////////////////////////////////////////////////////
    // Nice Reset States?
    /*
    assign MAINBUS = MAINRST ? 8'bZ : 8'b0;
    assign MEMDATA = MAINRST ? 8'bZ : 8'b0;
    assign LHSBUS  = MAINRST ? 8'bZ : 8'b0;
    assign RHSBUS  = MAINRST ? 8'bZ : 8'b0;
    assign ADDRBUS = MAINRST ? 16'bZ : 16'b0;
    assign XFERBUS = MAINRST ? 16'bZ : 16'b0;
    */
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
        .Pipe1Out_4_ALUOP0(PIPE1OUT[4]),
        .Pipe1Out_5_ALUOP1(PIPE1OUT[5]),
        .Pipe1Out_6_ALUOP2(PIPE1OUT[6]),
        .Pipe1Out_7_ALUOP3(PIPE1OUT[7]),
        
        // FLAGS (outputs)
        .Flags_0_Overflow(FLAGS[0]),
        .Flags_1_Sign(FLAGS[1]),
        .Flags_2_Zero(FLAGS[2]),
        .Flags_3_CarryA(FLAGS[3]),
        .Flags_4_CarryL(FLAGS[4]),
    
        // CARRYCTRL (inputs)
        .LCarryIn(FLAGS[4]),
        .Alu_Assert(w_alu_assert)
    );
    
    
    ///////////////////////////////////////////////////////////////////////////////
    // Bus Control
    
    BusControl buscontrol (
        // SIL4 CLK/RST (inputs)
        .Clock_In(MAINCLK),
        .Reset_In(FLAGS[6]),	// active low
        
        // SIL8 MAINBUSCTRL (inputs)
        .Bus_Assert(PIPE2OUT[3:0]), // [3:0]
        .Bus_Load(PIPE2OUT[7:4]), // [3:0]
        
        // SIL8 XFERBUSCTRL (inputs)
        .Xfer_Assert(PIPE1OUT[14:12]), // [2:0]
        .XferLoadDec(PIPE1OUT[11:8]), // [3:0]
        
        // SIL4 INC (inputs)
        .Inc_PCRA(PIPE0OUT[1:0]), // [1:0]
        .Inc_SPSIDI(PIPE2OUT[9:8]), // [1:0]
        
        // SIL4 ALUSEL (inputs)
        .LHS(PIPE1OUT[1:0]), // [1:0] (not LHSBUS)
        .RHS(PIPE1OUT[3:2]), // [1:0] (not RHSBUS)
        
        // SIL4 ADDRSEL (inputs)
        .AddrSel(PIPE2OUT[12:10]), // [2:0]
            
        // SIL5 A (outputs)
        .Reg_A_Load(w_a_load),
        .Reg_A_Assert(w_a_main_assert),
        .Reg_A_LHS(w_a_lhs_assert),
        .Reg_A_RHS(w_a_rhs_assert),
        
        // SIL5 B (outputs)
        .Reg_B_Load(w_b_load),
        .Reg_B_Assert(w_b_main_assert),
        .Reg_B_LHS(w_b_lhs_assert),
        .Reg_B_RHS(w_b_rhs_assert),
        
        // SIL5 C (outputs)
        .Reg_C_Load(w_c_load),
        .Reg_C_Assert(w_c_main_assert),
        .Reg_C_LHS(w_c_lhs_assert),
        .Reg_C_RHS(w_c_rhs_assert),
        
        // SIL5 D (outputs)
        .Reg_D_Load(w_d_load),
        .Reg_D_Assert(w_d_main_assert),
        .Reg_D_LHS(w_d_lhs_assert),
        .Reg_D_RHS(w_d_rhs_assert),
    
        // SIL4 CONST (outputs)
        .Reg_Const_LoadBus(), // not used
        .Reg_Const_LoadMem(w_const_load_n),
        .Reg_Const_Assert(w_const_a_main_n),
        
        // Register Shared Control Lines (outputs) - one per connector on PCBs
        .AddrRegClock(w_addrreg_clk),
        .AddrRegClear(w_addrreg_rst),
        
        // SIL8 PCRA0 (outputs)
        .Reg_PCRA0_Dec(w_reg_pcra0_dec),
        .Reg_PCRA0_Inc(w_reg_pcra0_inc),
        .Reg_PCRA0_Load(w_reg_pcra0_load),
        .Reg_PCRA0_AAddr(w_reg_pcra0_aaddr),
        .Reg_PCRA0_AXfer(w_reg_pcra0_axfer),
        
        // SIL8 PCRA1 (outputs)
        .Reg_PCRA1_Dec(w_reg_pcra1_dec),
        .Reg_PCRA1_Inc(w_reg_pcra1_inc),
        .Reg_PCRA1_Load(w_reg_pcra1_load),
        .Reg_PCRA1_AAddr(w_reg_pcra1_aaddr),
        .Reg_PCRA1_AXfer(w_reg_pcra1_axfer),
        
        // SIL8 SP (outputs)
        .Reg_SP_Dec(w_reg_sp_dec),
        .Reg_SP_Inc(w_reg_sp_inc),
        .Reg_SP_Load(w_reg_sp_load),
        .Reg_SP_AAddr(w_reg_sp_aaddr),
        .Reg_SP_AXfer(w_reg_sp_axfer),
        
        // SIL8 SI (outputs)
        .Reg_SI_Dec(w_reg_si_dec),
        .Reg_SI_Inc(w_reg_si_inc),
        .Reg_SI_Load(w_reg_si_load),
        .Reg_SI_AAddr(w_reg_si_aaddr),
        .Reg_SI_AXfer(w_reg_si_axfer),
        
        // SIL8 DI (outputs)
        .Reg_DI_Dec(w_reg_di_dec),
        .Reg_DI_Inc(w_reg_di_inc),
        .Reg_DI_Load(w_reg_di_load),
        .Reg_DI_AAddr(w_reg_di_aaddr),
        .Reg_DI_AXfer(w_reg_di_axfer),
        
        // SIL9 XFER (outputs)
        .Reg_TL_Load(w_reg_tl_load),
        .Reg_TL_Assert(w_reg_tl_assert),
        .Reg_TH_Load(w_reg_th_load),
        .Reg_TH_Assert(w_reg_th_assert),
        .Reg_TX_Load(w_reg_tx_load),
        .Reg_TX_AAddr(w_reg_tx_aaddr),
        .Reg_TX_AXfer(w_reg_tx_axfer),
        .Reg_TX_AMode(), // not used
            
        // SIL5 MEM (outputs)
        .MemBridge_Assert(w_mem_assert),
        .MemBridge_Load(w_mem_load),
        .MemBridge_Direction(w_mem_direction),
        .Memory_Ack(w_mem_ack),
        
        // SIL8 DEVICELOAD (outputs)
        .Dev9_Load(),    // not used
        .Dev10_Load(),   // not used
        .Dev11_Load(),   // not used
        .Dev12_Load(),   // not used
        .Dev13_Load(),   // not used
        .Dev14_Load(),   // not used
        
        // SIL8 DEVICEASSERT (outputs)
        .Alu_Assert(w_alu_assert),
        .Dev9_Assert(),  // not used
        .Dev10_Assert(), // not used
        .Dev11_Assert(), // not used
        .Dev12_Assert(), // not used
        .Dev13_Assert(), // not used
        .Dev14_Assert()  // not used
    );
    
    
    ///////////////////////////////////////////////////////////////////////////////
    // Constant Register
    
    ConstantRegisterV2 constantregister (
        .MemData(MEMDATA), // in
        .MainBus(MAINBUS), // out
        .a_main_n(w_const_a_main_n),
        .load(w_const_load_n)
    );
    
    
    ///////////////////////////////////////////////////////////////////////////////
    // Counter Address Register Group
    
    CAR_Group cargroup (
        .Addr(ADDRBUS), // io [15:0]
        .Xbus(XFERBUS), // io [15:0]
        .clock(w_addrreg_clk), // in
        .clear(w_addrreg_rst), // in (inverted in buscontrol compared to MAINRST and FLAG6)
        
        // PCRA0 (inputs)
        .pcra0_dec(w_reg_pcra0_dec),
        .pcra0_inc(w_reg_pcra0_inc),
        .pcra0_xbus_load(w_reg_pcra0_load),
        .pcra0_xbus_assert(w_reg_pcra0_axfer),
        .pcra0_addr_assert(w_reg_pcra0_aaddr),
        
        // PCRA1 (inputs)
        .pcra1_dec(w_reg_pcra1_dec),
        .pcra1_inc(w_reg_pcra1_inc),
        .pcra1_xbus_load(w_reg_pcra1_load),
        .pcra1_xbus_assert(w_reg_pcra1_axfer),
        .pcra1_addr_assert(w_reg_pcra1_aaddr),
        
        // SP (inputs)
        .sp_dec(w_reg_sp_dec),
        .sp_inc(w_reg_sp_inc),
        .sp_xbus_load(w_reg_sp_load),
        .sp_xbus_assert(w_reg_sp_axfer),
        .sp_addr_assert(w_reg_sp_aaddr),
        
        // SI (inputs)
        .si_dec(w_reg_si_dec),
        .si_inc(w_reg_si_inc),
        .si_xbus_load(w_reg_si_load),
        .si_xbus_assert(w_reg_si_axfer),
        .si_addr_assert(w_reg_si_aaddr),
        
        // DI (inputs)
        .di_dec(w_reg_di_dec),
        .di_inc(w_reg_di_inc),
        .di_xbus_load(w_reg_di_load),
        .di_xbus_assert(w_reg_di_axfer),
        .di_addr_assert(w_reg_di_aaddr)
    );
    
    
    ///////////////////////////////////////////////////////////////////////////////
    // General Purpose Register Group
    
    GPR_Group gprgroup (
        .MainBus(MAINBUS), //io
        .LHSBus(LHSBUS), // out
        .RHSBus(RHSBUS), // out
    
        // GPR A (inputs)
        .a_load(w_a_load),
        .a_main_assert(w_a_main_assert),
        .a_lhs_assert(w_a_lhs_assert),
        .a_rhs_assert(w_a_rhs_assert),
        
        // GPR B (inputs)
        .b_load(w_b_load),
        .b_main_assert(w_b_main_assert),
        .b_lhs_assert(w_b_lhs_assert),
        .b_rhs_assert(w_b_rhs_assert),
        
        // GPR C (inputs)
        .c_load(w_c_load),
        .c_main_assert(w_c_main_assert),
        .c_lhs_assert(w_c_lhs_assert),
        .c_rhs_assert(w_c_rhs_assert),
        
        // GPR D (inputs)
        .d_load(w_d_load),
        .d_main_assert(w_d_main_assert),
        .d_lhs_assert(w_d_lhs_assert),
        .d_rhs_assert(w_d_rhs_assert)
    );
    
    
    ///////////////////////////////////////////////////////////////////////////////
    // Transfer Register
    
    TransferRegisterV1 transferregister (
        .Addr(ADDRBUS),
        .Bus(XFERBUS),
        .MainBus(MAINBUS),
        .a_tl_n(w_reg_tl_assert),
        .l_tl_n(w_reg_tl_load),
        .a_th_n(w_reg_th_assert),
        .l_th_n(w_reg_th_load),
        .l_tx_n(w_reg_tx_load),
        .a_tx_addr_n(w_reg_tx_aaddr),
        .a_tx_xfer_n(w_reg_tx_axfer)
    );
    
    
    ///////////////////////////////////////////////////////////////////////////////
    // Main Memories (RAM and ROM)

    /*MainMemory3232 mainmemory3232 (
        .Addr(ADDRBUS), // in [15:0]
        .MEMDATA(MEMDATA), // inout [7:0]
        
        // Mem Inputs
        .MemBridge_Load(w_mem_load),
        .MemBridge_Direction(w_mem_direction) // high = memory module output
    );*/
    MainMemory64Shadow  mainmemory64 (
        .Addr(ADDRBUS), // in [15:0]
        .MEMDATA(MEMDATA), // inout [7:0]

        // Mem Inputs
        .MemBridge_Load(w_mem_load),
        .MemBridge_Direction(w_mem_direction),
        .Memory_Ack(w_mem_ack),
        .DebugMemoryErrorWeirdness(w_mem_debugerror)
    );
    
    ///////////////////////////////////////////////////////////////////////////////
    // Memory Bridge
    
    MemBridge membridge (
        .MainBus(MAINBUS),
        .MemData(MEMDATA),
        
        .a_membridge_n(w_mem_assert),	// active low, MemData->MainBus
        .d_membridge_n(w_mem_direction)	// active low, MainBus->MemData
    );
    
    
    ///////////////////////////////////////////////////////////////////////////////
    // Pipeline (check FetchSurpress & BusRequest when Synthesising)
    
    Pipeline pipeline (
        .ClockIn(MAINCLK), // in
        .MEMDATA(MEMDATA), // in
        .PipeOut(), // out (not used)
            
        // Control (outputs)
        .Pipe0Out(PIPE0OUT), // [1:0]
        .Pipe1Out(PIPE1OUT), // [15:0]
        .Pipe2Out(PIPE2OUT), // [15:0]
        
        // flag (inputs)
        .Flags(FLAGS) // [6:0]
    );
    assign FLAGS[5] = PIPE2OUT[14]; // Flags_5_PCRA_Flip = Pipe2Out_14_PCRA_Flip;
    assign FLAGS[6] = MAINRST;
    
    
// End
endmodule
