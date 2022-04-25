/*

Name:				Transfer Register V1
Schematic Source:   https://easyeda.com/weirdboyjim/transferregisterv1
Schematic Rev:		1.0 (2019-07-18)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
	Just an empty module with ports.
	
*/

module TransferRegisterV1 (
	inout	[7:0] 	MainBus,	// system bus
	inout	[15:0]	Addr,		// addressb bus
	inout	[15:0]	Bus,		// transfer bus
	input			a_tl,		// 
	input			l_tl,		// 
	input			a_th,		// 
	input			l_th,		// 
	input			l_tx,		// no idea on the polarity of these (check IC datasheets)
	input			a_tx_addr,	// 
	input			a_tx_xfer,	// 
	input			a_tx_mode	// 
);

	// main code goes here!

endmodule