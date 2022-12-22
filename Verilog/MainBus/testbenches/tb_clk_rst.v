`timescale 1ns / 1ps
// -----------------------------------------------------------------------------
// Title   : Crude Test Bench for 8b General Purpose Register (MainBus/tb_r8b_gpr.v)
// Create  : Wed 21 Dec 22:07:34 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : Test Bench for 8 bit general purpose register
// -----------------------------------------------------------------------------

module tb_clk_rst();
reg clk = 0;
reg rst = 0; // start with reset low
wire Q;

clock_reset DUT (
    .clk(clk),
    .reset_in_n(rst),
    .reset_out_n(Q)
);

initial begin
    forever #10 clk = ~clk;  
end
 
initial begin 
    #30; // 3 clock cyles
    rst = 1; // lift external reset button
    #200; // see what happens :)
    rst = 0; // press external reset button
    #20;
    rst = 1; // lift external reset button
    #200;
    $finish;
end 
endmodule