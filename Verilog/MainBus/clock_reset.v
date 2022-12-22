// -----------------------------------------------------------------------------
// Title   : Clock & Reset Logic (MainBus/clock_reset.v)
// Create  : Tue 20 Dec 22:31:57 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : On power up/reset button press, block waits 8 clock cycles then 
//         : releases the reset output (to high). This clears pipeline.
// -----------------------------------------------------------------------------

module clock_reset
(
    input        clk,
    input        reset_in_n,
    output       reset_out_n
);

	reg [2:0] cnt; // 3bit counter (counts down from 7 to 0)
	reg       rdy; // ready bit (1 is ready, 0 is not ready).
	
	// set initial values
	initial begin
		cnt = 3'b111; // max delay till starting
		rdy = 1'b0; // not ready
	end
	
	// update register on rising clock, iff load is low.
	always @ (posedge clk) begin
		if (!reset_in_n) begin
			cnt <= 3'b111; // reset
			rdy <= 1'b0;   
		end else if (cnt == 3'b0) begin
			cnt <= 3'b000;
			rdy <= 1'b1;
		end else begin
			cnt <= cnt - 1'b1;
			rdy <= 1'b0;
		end
	end
    
    assign reset_out_n = rdy;

endmodule //end:clock_reset

