// -----------------------------------------------------------------------------
// Title   : Pipeline Stage 1 (Pipeline/pipe_stage1.v)
// Create  : Tue 20 Dec 22:32:28 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : Pipeline Stage 1
//         : Original schematic: https://oshwlab.com/weirdboyjim/Pipeline-Stage-1
// -----------------------------------------------------------------------------

module pipe_stage1
(
    input        clk,
    input  [7:0] PipeIn,
    input        BusRequest,
    input        Flag0_Overflow,
    input        Flag1_Sign,
    input        Flag2_Zero,
    input        Flag3_CarryA,
    input        Flag4_CarryL,
    input        Flag5_PCRA_Flip,
    input        Flag6_Reset,
    
    output [7:0] Pipe1Out,
    output       Pipe1Out0_LHS0,
    output       Pipe1Out1_LHS1,
    output       Pipe1Out2_RHS0,
    output       Pipe1Out3_RHS1,
    output       Pipe1Out4_ALUOP0,
    output       Pipe1Out5_ALUOP1,
    output       Pipe1Out6_ALUOP2,
    output       Pipe1Out7_ALUOP3,
    output       Pipe1Out8_XLD0,
    output       Pipe1Out9_XLD1,
    output       Pipe1Out10_XLD2,
    output       Pipe1Out11_XLD3,
    output       Pipe1Out12_XA0,
    output       Pipe1Out13_XA1,
    output       Pipe1Out14_XA2,
    output       Pipe1Out15_FetchSuppress
);

	// Assemble address bus for ROM to match James' schematic
	wire [15:0] addrbus = {Flag6_Reset, Flag5_PCRA_Flip, Flag4_CarryL, Flag3_CarryA, Flag2_Zero, Flag1_Sign, Flag0_Overflow, PipeIn};

    // Pipe ROM 1A - match ROM data bus James' schematic
	wire [7:0] rom1a_out;
	pipeline_rom_1a rom1a ( .clk(clk), .en(1'b1), .addr(addrbus), .dout(rom1a_out) );
	assign Pipe1Out0_LHS0   = rom1a_out[0];
    assign Pipe1Out1_LHS1   = rom1a_out[1];
    assign Pipe1Out2_RHS0   = rom1a_out[2];
    assign Pipe1Out3_RHS1   = rom1a_out[3];
    assign Pipe1Out4_ALUOP0 = rom1a_out[4];
    assign Pipe1Out5_ALUOP1 = rom1a_out[5];
    assign Pipe1Out6_ALUOP2 = rom1a_out[6];
    assign Pipe1Out7_ALUOP3 = rom1a_out[7];
	
	// Pipe ROM 1B - match ROM data bus James' schematic
	wire [7:0] rom1b_out;
	pipeline_rom_1b rom1b ( .clk(clk), .en(1'b1), .addr(addrbus), .dout(rom1b_out) );
	assign Pipe1Out8_XLD0  = rom1b_out[0];
    assign Pipe1Out9_XLD1  = rom1b_out[1];
    assign Pipe1Out10_XLD2 = rom1b_out[2];
    assign Pipe1Out11_XLD3 = rom1b_out[3];
    assign Pipe1Out12_XA0  = rom1b_out[4];
    assign Pipe1Out13_XA1  = rom1b_out[5];
    assign Pipe1Out14_XA2  = rom1b_out[6];
    assign Pipe1Out15_FetchSuppress = rom1b_out[7];
	
	// Latch the PipeIn Word
	reg [7:0] PipeLatch;
	
	// update PipeLatch on clk posedge
	always @ (posedge clk) begin
		PipeLatch <= PipeIn;
	end
	
	// PipeOut if NAND(FS, BR), else all low.
	assign Pipe1Out = (~(Pipe1Out15_FetchSuppress & BusRequest) ? PipeLatch : 8'b0;

endmodule //end:pipe_stage1
