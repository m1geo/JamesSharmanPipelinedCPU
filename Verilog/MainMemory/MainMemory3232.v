/*

Name:				MainMemory3232
Schematic Source:   https://easyeda.com/weirdboyjim/MainMemory3232
Schematic Rev:		1.0 (2020-03-08)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU

Module notes:
	Just an empty module with ports.
	See also MainMemory64Shadown which copies ROM to RAM and then runs.

	RAM ideas from 	https://github.com/DoctorWkt/CSCvon8/blob/master/ram.v
*/

module MainMemory3232 (
	input	[15:0] 	Addr,
	inout	[7:0]	MEMDATA,
	
	// Mem Inputs
	input			MemBridge_Load,
	input			MemBridge_Direction
);

	// Program ROM file
	localparam ProgRom_File = "Monitor.mem";

	// Rom elements
	reg [7:0] ProgRom [0:32767]; // 32k
	reg [7:0] Ram     [0:32767]; // 32k
	
	// Load ROM from file
	initial begin
		$readmemh(ProgRom_File, ProgRom);
	end
	
	// Memory Control Lines (all act low)
	wire RomCE;
	wire RamCE;
	wire RamWE;
	wire MemOE;
	assign MemOE = ~MemBridge_Direction;
	assign {RamCE, RomCE} = ~(1 << Addr[15]); // one cold decoder
	assign RamWE = MemBridge_Load; // on PCB there are 4 inverter gate delays between MemBridge_Load & RamWE.
	
	
	// ROM Output
	assign MEMDATA = (!RomCE && !MemOE) ? ProgRom[Addr[14:0]] : 8'bZ;
	
	// RAM Output
	assign MEMDATA = (!RamCE && !MemOE) ? Ram[Addr[14:0]] : 8'bZ;
	
	//assign MEMDATA = MemOE ? 8'bZ : (Addr[15] ? Ram[Addr[14:0]] : ProgRom[Addr[14:0]]);
	
	// RAM Write
	always @(negedge RamCE or negedge RamWE or negedge MemOE) begin
		if (!RamCE && !RamWE) begin
			Ram[Addr[14:0]] <= MEMDATA;
		end
		if (!RamWE && !MemOE)
			$display("ram error: both MemOE & RamWE active (low)");
	end

endmodule