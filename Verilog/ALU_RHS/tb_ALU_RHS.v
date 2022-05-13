/*

Name:				ALU_RHS - TESTBENCH

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-05-13)

Module notes:
    Testbench for ALU RHS
	
	Video1:		https://www.youtube.com/watch?v=pMV_0qT0uY0 (design of logic)
	Video2:		https://www.youtube.com/watch?v=3k-Batj7t-0 (design of PCB + register)
	
	Design based on Julian Ilett's video on the 74LS253 as a configurable
	logic gate: https://www.youtube.com/watch?v=15M63Zqkthk
	
	Functions provided:
		(AC[3:0]=4'b1100) RHS straight through
		(AC[3:0]=4'b0011) inverted RHS (for subtraction) 
		(AC[3:0]=4'b0000) Zero operation
		(AC[3:0]=4'b1111) 255 output
		(AC[3:0]=4'b1000) LHS AND RHS
		(AC[3:0]=4'b1110) LHS OR RHS
		(AC[3:0]=4'b0110) LHS XOR RHS
*/

// unimportant timescale.
`timescale 1 ns/10 ps

module tb_ALU_RHS();
localparam period = 10; // period is 10 nanoseconds
localparam clkstep = 1; // clocktick is 1 nanosecond

reg tb_clk;
reg [7:0] tb_LHS = 0;
reg [7:0] tb_RHS = 0;
reg [3:0] tb_AC_RHS = 0;

wire [7:0] tb_Logic;

ALU_RHS DUT (
	.AluClock(tb_clk),
	.LHS(tb_LHS),
	.RHS(tb_RHS),
	.Logic(tb_Logic), // out
	
	.AC0_RHS0(tb_AC_RHS[0]),
	.AC1_RHS1(tb_AC_RHS[1]),
	.AC2_RHS2(tb_AC_RHS[2]),
	.AC3_RHS3(tb_AC_RHS[3])
);

    always #clkstep tb_clk = !tb_clk;

    // this happens first
    initial begin
        // init clock
        tb_clk = 0;
        
        // init monitor
        $monitor  ("[$monitor]  time=%0t LHS=0x%0h RHS=0x%0h AC=0x%0h OUT=0x%0h", $time, tb_LHS, tb_RHS, tb_AC_RHS, tb_Logic);
        
		tb_LHS      = 8'b11001100;
		tb_RHS      = 8'b11110000;
		tb_AC_RHS 	= 0;
    end
       
    // Loop to unroll the test cases
    genvar i;
    generate
        for (i = 0; i < 16 ; i = i + 1) begin // control signal 0-to-15.
            initial begin
                #(period*i);
                tb_LHS      = 8'b11001100;
                tb_RHS      = 8'b11110000;
                tb_AC_RHS 	= i;
            end
        end
    endgenerate 

    // this happens last
    initial #(period*16) $finish;
    
endmodule // end testbench