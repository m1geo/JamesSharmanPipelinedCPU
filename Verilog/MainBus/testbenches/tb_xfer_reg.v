`timescale 1ns / 1ps
// -----------------------------------------------------------------------------
// Title   : Crude Test Bench for 16b Transfer Register
// Create  : Wed 21 Dec 22:07:34 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : Test Bench for 16b Transfer Register
// -----------------------------------------------------------------------------

module tb_xfer_reg(); // testbench
reg [7:0] MB = 0;
reg [15:0] XB = 0;
reg clk;
reg load_tx  = 1;
reg load_mbh = 1;
reg load_mbl = 1;
wire [15:0] Q16;

r16b_xfer DUT
(
    .clk(clk),
    .reg_xfer_load(load_tx), // active low
    .reg_main_low_load(load_mbl), // active low
    .reg_main_high_load(load_mbh), // active low
    .XferBusIn(XB),
    .MainBusIn(MB),
    .RegOut(Q16)
);

initial begin
    clk=0;
    forever #10 clk = ~clk;  
end


 
initial begin 
    #100; // just let clock run
    
    // load 0xDEAD into TX from MainBus in two transactions.
    MB = 8'hDE;
    load_mbh = 0;
    #20;
    load_mbh = 1;
    MB = 8'hAD;
    load_mbl = 0;
    #20;
    MB = 8'hFF;
    load_mbl = 1;
    #40;
    XB = 16'hCAFE;
    load_tx = 0;
    #20;
    load_tx = 1;
    #100;
    $finish;
end 
endmodule
