// -----------------------------------------------------------------------------
// Title   : 16b Register (up, down, load) (MainBus/r16b_updnld.v)
// Create  : Tue 20 Dec 22:32:06 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : 16 bit register with up, down and load. For PCRA, SP, SI, DI.
//         : PCB uses 74HCT193 and synced to clk with 74HCT574.
// -----------------------------------------------------------------------------

module r16b_updnld
(
    input         clk,
    input         clear,
    input         reg_load, // active low
    input         inc, // active high
    input         dec, // active high
    input  [15:0] XferBusIn,
    
    output [15:0] RegOut
);

	// define register
	reg [15:0] data;
	
	// update register on rising clock
	always @ (posedge clk) begin
		if (clear) begin
			data <= 16'b0; // clear
		end else if (!reg_load) begin
			data <= XferBusIn; // load_n
		end else if (inc) begin
			data <= data + 1'b1; // inc
		end else if (dec) begin
			data <= data - 1'b1; // dec
		end
	end
	
	// always expose the register data. 
	// asserts handled outside of the register on FPGA.
	assign RegOut = data;

endmodule //end:r16b_updnld
