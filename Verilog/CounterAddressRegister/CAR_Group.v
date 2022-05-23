/*

Name:				Counter Address Register Group

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
	This module joins the four CARs together. Not massively useful, but tider on top level view.
*/

// Include Submodules.
`include "CounterAddressRegister.v


module CAR_Group (
	inout	[15:0] 	Addr,
	inout	[15:0]	Xbus,
	input			clock,
	input			clear,
	
	// PCRA0
	input			pcra0_dec,
	input			pcra0_inc,
	input			pcra0_xbus_load,
	input			pcra0_xbus_assert,
	input			pcra0_addr_assert,
	
	// PCRA1
	input			pcra1_dec,
	input			pcra1_inc,
	input			pcra1_xbus_load,
	input			pcra1_xbus_assert,
	input			pcra1_addr_assert,
	
	// SP
	input			sp_dec,
	input			sp_inc,
	input			sp_xbus_load,
	input			sp_xbus_assert,
	input			sp_addr_assert,
	
	// SI
	input			si_dec,
	input			si_inc,
	input			si_xbus_load,
	input			si_xbus_assert,
	input			si_addr_assert,
	
	// DI
	input			di_dec,
	input			di_inc,
	input			di_xbus_load,
	input			di_xbus_assert,
	input			di_addr_assert,
);

	// PCRA0 (Program Counter/Return Address)
	CounterAddressRegister car_pcra0 (
		.Addr(Addr),
		.Bus(Xbus),
		.clock(clock),
		.clear(clear),
		.dec(pcra0_dec),
		.inc(pcra0_inc),
		.load_n(pcra0_xbus_load),
		.a_addr_n(pcra0_addr_assert),
		.a_bus_n(pcra0_addr_assert)
	);
	
	// PCRA1 (Program Counter/Return Address)
	CounterAddressRegister car_pcra1 (
		.Addr(Addr),
		.Bus(Xbus),
		.clock(clock),
		.clear(clear),
		.dec(pcra1_dec),
		.inc(pcra1_inc),
		.load_n(pcra1_xbus_load),
		.a_addr_n(pcra1_addr_assert),
		.a_bus_n(pcra1_addr_assert)
	);

	// SP (Stack Pointer)
	CounterAddressRegister car_sp (
		.Addr(Addr),
		.Bus(Xbus),
		.clock(clock),
		.clear(clear),
		.dec(sp_dec),
		.inc(sp_inc),
		.load_n(sp_xbus_load),
		.a_addr_n(sp_addr_assert),
		.a_bus_n(sp_addr_assert)
	);
	
	// SI (Source Index)
	CounterAddressRegister car_si (
		.Addr(Addr),
		.Bus(Xbus),
		.clock(clock),
		.clear(clear),
		.dec(si_dec),
		.inc(si_inc),
		.load_n(si_xbus_load),
		.a_addr_n(si_addr_assert),
		.a_bus_n(si_addr_assert)
	);

	// DI (Destination Index)
	CounterAddressRegister car_di (
		.Addr(Addr),
		.Bus(Xbus),
		.clock(clock),
		.clear(clear),
		.dec(di_dec),
		.inc(di_inc),
		.load_n(di_xbus_load),
		.a_addr_n(di_addr_assert),
		.a_bus_n(di_addr_assert)
	);

endmodule