/*

Name:				Transfer Register V1
Schematic Source:	https://easyeda.com/weirdboyjim/transferregisterv1
Schematic Rev:		1.0 (2019-07-18)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog:		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
	Just an empty module with ports.
	
*/

module TransferRegisterV1 (
	inout	[7:0] 	MainBus,	// system bus
	inout	[15:0]	Addr,		// address bus
	inout	[15:0]	Bus,		// transfer bus
	input			a_tl_n,		// 
	input			l_tl_n,		// 
	input			a_th_n,		// 
	input			l_th_n,		// 
	input			l_tx_n,		// All signals active low
	input			a_tx_addr_n,// 
	input			a_tx_xfer_n // 
	//input			a_tx_mode_n	// // not used (goes to inverter on hardware)
);

	// the actual register
	reg [15:0] Q_reg;
	
	// output of input mux
	wire [15:0] input_mux;
	
	// input mux - wasteful mux - no priority if more than one mux is selected!
	assign input_mux = l_tl_n ? 16'bZ : {Q_reg[15:8], MainBus[7:0]}; // update low with mainbus
	assign input_mux = l_th_n ? 16'bZ : {MainBus[7:0], Q_reg[7:0]}; // update high with mainbus
	assign input_mux = l_tx_n ? 16'bZ : Bus; // update high with mainbus
	
	// the register assignment
	always @(posedge l_tl_n or posedge l_th_n or posedge l_tx_n)
		Q_reg <= input_mux;
	
	// assert to address bus when a_tx_addr_n is LOW; else High-Z.
	assign Addr = a_tx_addr_n ? 16'bZ : Q_reg;
	
	// assert to transfer bus when a_tx_xfer_n is LOW; else High-Z.
	assign Bus = a_tx_xfer_n ? 16'bZ : Q_reg;
	
	// assert to main bus (low/high) when a_t(l/h)_n is LOW; else High-Z.
	assign MainBus = a_tl_n ? 16'bZ : Q_reg[7:0]; // low
	assign MainBus = a_th_n ? 16'bZ : Q_reg[15:8]; // high

endmodule