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

module tb_gpr(); // testbench
reg [7:0] D;
reg clk;
reg clr;
reg load;
reg inc;
reg dec;
wire [7:0] Q8;
wire [15:0] Q16;

r8b_gpr DUT8
(
    .clk(clk),
    .reg_load(load),
    .RegIn(D[7:0]),
    .RegOut(Q8)
);

r16b_updnld DUT16
(
    .clk(clk),
    .clear(clr),
    .reg_load(load),
    .inc(inc),
    .dec(dec),
    .XferBusIn({D[7:0], D[7:0]}),
    .RegOut(Q16)
);

initial begin
  clk=0;
     forever #10 clk = ~clk;  
end 
initial begin 
 clr=1;
 load=1;
 inc=0;
 dec=0;
 D <= 0;
 #20;
 clr=0;
 #100;
 load=0;
 D <= 1;
 #100;
 D <= 0;
 load=1;
 #100;
 D <= 123;
 #50;
 load=0;
 #10;
 load=1;
 #20
 inc=1;
 #50;
 inc=0;
 #100;
 dec=1;
 #50;
 dec=0;
 #100;
 clr=1;
 #20;
 clr=0;
 #50;
end 
endmodule 