/*

Name:				Diode Matrix
Schematic Source:   https://easyeda.com/weirdboyjim/DiodeMatrix
Schematic Rev:		1.0 (2019-04-20)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
	Just an empty module with ports.
	Will likely just be some ROM or some LUT thing.
	Schematic doesn't show diode configurations - Rewatch video.
	
*/

module DiodeMatrix (
	input	[3:0] 	Addr,
	input			Select,
	output	[7:0]	DataOut // weak pullup in hardware on James' design. 
);

	// main code goes here!

endmodule