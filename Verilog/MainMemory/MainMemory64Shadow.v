/*
Name:				MainMemory64Shadow
Schematic Source:   https://easyeda.com/weirdboyjim/MainMemory3232_copy
Schematic Rev:		2.0 (2020-03-08)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
	ROM is bottom half of memory (0000-7FFF): https://www.youtube.com/watch?v=v_GfZZ_sSxg&t=18

	This code does not replicate any of James' copy logic since we can use
	the Xilinx Tools to preload the memory from the FPGA bit file.
	Once reset is released, operation should be the same.
	Just need to get the Xilinx "initial" statement to put monitor in the right place!
*/

module MainMemory64Shadow #(
	parameter ROM_DATA_FILE = "Monitor.mem"
)(
	input	[15:0] 	Addr,
	inout	[7:0]	MEMDATA,
	
	// Mem Inputs
	input			MemBridge_Load,
	input			MemBridge_Direction,
	input			Memory_Ack,
	output reg		DebugMemoryErrorWeirdness
);

	(* RAM_STYLE="BLOCK" *) reg [7:0] ram [65535:0]; // 64k RAM
	
	// fill ROM/RAM areas as needed
	initial begin
      $readmemh(ROM_DATA_FILE, ram, 16'h0000, 16'h7FFF); // ROM at bottom of memory
	  //$readmemh(RAM_DATA_FILE, ram, 16'h8000, 16'hFFFF); // RAM at top of memory
	end

	// output data register
	reg [7:0] output_data;
	//wire memOE = ((!MemBridge_Direction) || (!Memory_Ack)); // U10 & U11
	wire memOE = ((!MemBridge_Direction) || (!Memory_Ack)); // U10 & U11
	
	// tristate output
	assign MEMDATA = (!memOE) ? ram[Addr] : 8'bZ;
	
	always @(negedge MemBridge_Load or negedge memOE) begin
		if (!MemBridge_Load) begin
			ram[Addr] <= MEMDATA;
		end
		output_data <= ram[Addr];
		DebugMemoryErrorWeirdness <= (!MemBridge_Load && !memOE); // error - both /OE & /WE set
	end


endmodule
