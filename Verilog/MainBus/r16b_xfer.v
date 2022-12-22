// -----------------------------------------------------------------------------
// Title   : 16b Transfer Register (MainBus/r16b_xfer.v)
// Create  : Tue 20 Dec 22:32:11 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : 16 bit transfer register
//         : PCB uses 74HCT574 (with lots of extra stuff)
// -----------------------------------------------------------------------------

module r16b_xfer
(
    input         clk,
    input         reg_xfer_load, // active low
    input         reg_main_low_load, // active low
    input         reg_main_high_load, // active low
    input  [15:0] XferBusIn,
    input   [7:0] MainBusIn,
    
    output [15:0] RegOut
);

    // define register
	reg [15:0] data;
	
	// update register on rising clock
	always @ (posedge clk) begin
		if (!reg_xfer_load) begin
			data <= XferBusIn; // load 16b transfer
		end else if (!reg_main_high_load) begin
			data <= {MainBusIn[7:0], data[7:0]}; // load 8b main high
		end else if (!reg_main_low_load) begin
			data <= {data[15:8], MainBusIn[7:0]}; // load 8b main low
		end
	end
	
	// always expose the register data. 
	// asserts handled outside of the register on FPGA.
	assign RegOut = data;

endmodule //end:r16b_xfer
