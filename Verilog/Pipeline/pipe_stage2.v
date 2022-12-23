// -----------------------------------------------------------------------------
// Title   : Pipeline Stage 2 (Pipeline/pipe_stage2.v)
// Create  : Tue 20 Dec 22:32:32 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : Pipeline Stage 2
//         : Original schematic: https://oshwlab.com/weirdboyjim/pipeline-stage-2
// -----------------------------------------------------------------------------

module pipe_stage2
(
    input        clk,
    input  [7:0] PipeIn,
    input        Flag0_Overflow,
    input        Flag1_Sign,
    input        Flag2_Zero,
    input        Flag3_CarryA,
    input        Flag4_CarryL,
    input        Flag5_PCRA_Flip,
    input        Flag6_Reset,
    
    output [7:0] Pipe2Out,
    output       Pipe2Out0_MA0, // main bus asserts
    output       Pipe2Out1_MA1,
    output       Pipe2Out2_MA2,
    output       Pipe2Out3_MA3,
    output       Pipe2Out4_ML0, // main bus loads
    output       Pipe2Out5_ML1,
    output       Pipe2Out6_ML2,
    output       Pipe2Out7_ML3,
    output       Pipe2Out8_Inc0,
    output       Pipe2Out9_Inc1,
    output       Pipe2Out10_Addr0,
    output       Pipe2Out11_Addr1,
    output       Pipe2Out12_Addr2,
    output       Pipe2Out13_BusRequest,
    output       Pipe2Out14_PCRA_Flip,
    output       Pipe2Out15_Break
);

	// Assemble address bus for ROM to match James' schematic
	wire [15:0] addrbus = {Flag6_Reset, Flag5_PCRA_Flip, Flag4_CarryL, Flag3_CarryA, Flag2_Zero, Flag1_Sign, Flag0_Overflow, PipeIn};

    // Pipe ROM 2A - match ROM data bus James' schematic
	wire [7:0] rom2a_out;
	pipeline_rom_2a rom2a ( .clk(clk), .en(1'b1), .addr(addrbus), .dout(rom2a_out) );
	assign Pipe2Out0_MA0 = rom2a_out[0];
    assign Pipe2Out1_MA1 = rom2a_out[1];
    assign Pipe2Out2_MA2 = rom2a_out[2];
    assign Pipe2Out3_MA3 = rom2a_out[3];
    assign Pipe2Out4_ML0 = rom2a_out[4];
    assign Pipe2Out5_ML1 = rom2a_out[5];
    assign Pipe2Out6_ML2 = rom2a_out[6];
    assign Pipe2Out7_ML3 = rom2a_out[7];
	
	// Pipe ROM 2B - match ROM data bus James' schematic
	wire [7:0] rom2b_out;
	pipeline_rom_2b rom2b ( .clk(clk), .en(1'b1), .addr(addrbus), .dout(rom2b_out) );
	assign Pipe2Out8_Inc0        = rom2b_out[0];
    assign Pipe2Out9_Inc1        = rom2b_out[1];
    assign Pipe2Out10_Addr0      = rom2b_out[2];
    assign Pipe2Out11_Addr1      = rom2b_out[3];
    assign Pipe2Out12_Addr2      = rom2b_out[4];
    assign Pipe2Out13_BusRequest = rom2b_out[5];
    assign Pipe2Out14_PCRA_Flip  = rom2b_out[6];
    assign Pipe2Out15_Break      = rom2b_out[7];
	
	// Latch the PipeIn Word
	reg [7:0] PipeLatch;
	
	// update PipeLatch on clk posedge
	always @ (posedge clk) begin
		PipeLatch <= PipeIn;
	end
	
	// PipeOut
	assign Pipe2Out = PipeLatch;


endmodule //end:pipe_stage2
