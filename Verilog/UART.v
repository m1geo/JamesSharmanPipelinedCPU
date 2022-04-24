/*

Name:				UART
Schematic Source:   https://easyeda.com/weirdboyjim/UART
Schematic Rev:		1.0 (2021-04-01)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
	Just an empty module with ports.
	
*/

module ALU_Control (
	input			UartClock,

	inout	[7:0]	MainBus,

	output	[7:0]	RcvData,
	input	[7:0]	TxData,
	
	// UART Port Signals
	input			RX,
	output			TX,
	
	// UART Ctrl
	output			ByteRcv,
	output			TFdataRead,
	input			Dev12_Assert,
	input 			Dev11_Load,
	input			Dev11_Assert,
	
	// FIFO_STATUS2
	inout	[3:0]	TFcount,
	inout	[3:0]	RFcount,
	

);

	// main code goes here!

endmodule