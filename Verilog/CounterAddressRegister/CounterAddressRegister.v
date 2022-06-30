/*

Name:				Counter/Address Register V1
Schematic Source:   https://easyeda.com/weirdboyjim/8bit-CPU
Schematic Rev:		1.0 (2019-01-13)
Designer:			James Sharman (weirdboyjim)

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-04-27)

Module notes:
	Video:			https://www.youtube.com/watch?v=Ok4g0sK-x28
	16 bit loadable counter. Load from Bus on falling LOAD_n.
	Assert to XFER bus on low a_bus_n. Assert to ADDR bus on low a_addr_n.
	Data is intentionally doubly registered, as it is on the schematic.
	Inc & Dec are a bit hacky as they rely on triggering from both edges.
*/

module CounterAddressRegister (
	inout	[15:0] 	Addr,
	inout	[15:0]	Bus,
	input			clock,	
	input			clear,		// active high
	input			dec,		// active rising edge
	input			inc,		// active rising edge
	input			load_n,		// active low
	input			a_addr_n,	// active low
	input			a_bus_n		// active low
);

    // 16 bit counter - behaviour to mimic 4x 74193 in cascade.
    reg [15:0] C_reg;
    reg dec_old = 0;
    reg inc_old = 0;
	always @(posedge clear or negedge load_n or posedge inc or posedge dec)
    begin
      inc_old <= inc;
      dec_old <= dec;
      if (clear)
        C_reg <= 16'b0;
      else if (~load_n)
        C_reg <= Bus;
      else if ((inc) && (~inc_old)) // a bit hacky
        C_reg <= C_reg + 1;
      else if ((dec) && (~dec_old)) // a bit hacky
        C_reg <= C_reg - 1;
    end
       
    // second latch for outputs clocked by Clock
    reg [15:0] OP_reg;
    always @ (posedge clock)
		OP_reg <= C_reg;
    
    // assert to transfer bus when a_bus_n is LOW; else High-Z.
	assign Bus = a_bus_n  ? 16'bZ : OP_reg;
	
	// assert to address bus when a_addr_n is LOW; else High-Z.
	assign Addr = a_addr_n ? 16'bZ : OP_reg;

endmodule