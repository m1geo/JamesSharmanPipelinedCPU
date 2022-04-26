/*

Name:				Constant Register V2
Schematic Source:   https://easyeda.com/weirdboyjim/constantregisterv1_copy
Schematic Rev:		2.0 (2019-01-13)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-04-26)

Module notes:
	Video: 			https://www.youtube.com/watch?v=oulnr5_5rFU
	Only U2 is implimented as the rest of the logic is to drive LEDs and only
	show them when relevant.
*/

module ConstantRegisterV2 (
	input	[7:0]	MemData,
	output	[7:0] 	MainBus,
	input			a_main_n,	// active low
	input			load		// active high
);

	// Module is a super simple latch
	reg [7:0] Q_reg;
	
	// Copy to register on LOW->HIGH of load
	always @ (posedge load)
		Q_reg <= MemData;
	
	// assert to main bus when assert is LOW; else High-Z.
	assign MainBus = a_main_n ? 8'bZ : Q_reg;

endmodule