// -----------------------------------------------------------------------------
// Title   : 8b General Purpose Register (MainBus/r8b_gpr.v)
// Create  : Tue 20 Dec 22:32:12 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : 8 bit general purpose register
//         : also used for constant register
//         : PCB uses 74HCT574
// -----------------------------------------------------------------------------

module r8b_gpr
(
    input        clk,
    input        reg_load, // active low
    input  [7:0] RegIn,
    
    output [7:0] RegOut
);

	// define register
	reg [7:0] data;
	
	// update register on rising clock, iff load is low.
	always @ (posedge clk) begin
		if (!reg_load) begin
			data <= RegIn;
		end
	end
	
	// always expose the register data. 
	// asserts handled outside of the register on FPGA.
	assign RegOut = data;

endmodule //end:r8b_gpr
