`timescale 1ns / 1ps
// -----------------------------------------------------------------------------
// Title   : Crude Test Bench for Diode Matrix
// Create  : Thu 22 Dec 00:58:35 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : Test Bench for Diode Matrix
// -----------------------------------------------------------------------------

module tb_diode_matrix();

reg  [3:0] tb_ALUOP = 0;
wire [3:0] tb_LogicSelect;
wire       tb_SSA;
wire       tb_SSB;
wire       tb_CSA;
wire       tb_CSB;

diode_matrix DUT (
    .ALUOP(tb_ALUOP),
    .LogicSelect(tb_LogicSelect),
    .ShiftSelectA(tb_SSA),
    .ShiftSelectB(tb_SSB),
    .CarrySelectA(tb_CSA),
    .CarrySelectB(tb_CSB)
);

initial begin
    forever #10 tb_ALUOP = tb_ALUOP + 1;  
end
 
initial begin 
    #200;
    $finish;
end 
endmodule