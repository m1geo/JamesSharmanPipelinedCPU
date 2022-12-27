// -----------------------------------------------------------------------------
// Title   : Memory (RAM & ROM) (MainBus/memory.v)
// Create  : Tue 20 Dec 22:32:02 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : Combined RAM+ROM to use BRAM in FPGA
//         : There's some magic in here. Check the schematics carefully.
//         : 
//         : MemBridge_Assert is /OE for MainBus Bus
//         : MemBridge_Direction is /OE for MemData Bus
//         :  \=> also drives /OE for RAM/ROM ICs onto MemData Bus
//         :
//         : Based on Xilinx Single-Port Block RAM Write-First Mode Verilog Example
// -----------------------------------------------------------------------------

/*

NOT FINISHEED YET - NEEDS CONTROL LINES ADDING!

*/

module memory
(
	input         clk,
    input  [15:0] AddrBus,
    input   [7:0] MemDataIn,
    input   [7:0] MainBusIn,
    input         MemBridge_Dir, // check what this does, and if it should be in the 8bit MUXes.
    input         MemBridge_Load, // active low
    input         MemBridge_Assert, // check what this does, and if it should be in the 8bit MUXes.
    
    output  [7:0] MemDataOut,
    output  [7:0] MainBusOut
);

	// Input MUX
	wire [7:0] di = (xxx) ? MemDataIn : MainBusIn;
	
	// RAM array (64KBytes)
	reg [7:0] RAM [65535:0];
	
	// Output Register
	reg [7:0] dout;
	assign MemDataOut = dout;
	assign MainBusOut = dout;
	
	// Memory BRAM
    always @(posedge clk) begin
        if (en) begin
            if (we) begin
                RAM[AddrBus] <= di;
                dout <= di;
            end else  // end:if_we
                dout <= RAM[AddrBus];
        end // end:if_en
    end // end:always_posedge_clk

endmodule //end:memory
