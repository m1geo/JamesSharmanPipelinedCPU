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
	
	This is tricky because the FPGA has single clock FFs, and not SR latches.
	I've used the clock to sync the output and big MUX to chose the next value.
	If not acceptable, copy logic from datasheet?
	https://www.ti.com/lit/ds/symlink/sn54ls193-sp.pdf
	
	The edge detection shift-registers may not work if the clock isn't faster than the data (which this isn't). Maybe any edge (_sr[1]^_sr[0]) is better? Datahsheet says rising. James' design has a second latch.
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
    wire [15:0] C_wire;
    
    // latch for outputs clocked by Clock
    reg [15:0] OP_reg;
    
    reg [1:0] inc_sr;
    reg [1:0] dec_sr;
    
    // input mux to avoid weird async logic of 74193.
    assign C_wire = clear ? 16'b0 : 
                        ~load_n ? Bus : 
                            (inc_sr==2'b01) ? (OP_reg + 16'b1) : // rising edge of inc
                                (dec_sr==2'b01) ? (OP_reg - 16'b1) : OP_reg; // rising edge of dec

    always @ (posedge clock) begin
		OP_reg <= C_wire;
		inc_sr = {inc_sr[0], inc}; // shift register for edge detection
		dec_sr = {dec_sr[0], dec}; // shift register for edge detection
	end
    
    // assert to transfer bus when a_bus_n is LOW; else High-Z.
	assign Bus = a_bus_n  ? 16'bZ : OP_reg;
	
	// assert to address bus when a_addr_n is LOW; else High-Z.
	assign Addr = a_addr_n ? 16'bZ : OP_reg;

endmodule