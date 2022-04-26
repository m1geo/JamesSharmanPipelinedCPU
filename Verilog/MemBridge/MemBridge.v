/*

Name:				Mem Bridge
Schematic Source:   https://easyeda.com/weirdboyjim/membridge
Schematic Rev:		1.0 (2020-03-08?)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
    Video:          https://www.youtube.com/watch?v=kFNIyoW6VMo&t=6s
	Bidirectional bridge between MainBus and MemData.
	
*/

module MemBridge (
	inout	[7:0]	MainBus,
	inout	[7:0]	MemData,
	
	// Mem Inputs
	input			a_membridge_n,	// active low, MemData->MainBus
	input			d_membridge_n	// active low, MainBus->MemData
);

    // LOW a_membridge_n drives MemData onto MainBus
	assign MainBus = a_membridge_n ? 8'bZ : MemData;
	
	// LOW d_membridge_n drives MainBus onto MemData
	assign MemData = d_membridge_n ? 8'bZ : MainBus;

endmodule
