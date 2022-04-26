/*

Name:				Constant Register V2 - TESTBENCH

FPGA/Verilog: 		George Smart (@m1geo) http://www.george-smart.co.uk
Project Source:		https://github.com/m1geo/JamesSharmanPipelinedCPU
Verilog Rev:		1.0 (2022-04-26)

Module notes:
    Testbench for V2 constant register 
    
*/

// unimportant timescale.
`timescale 1 ns/10 ps

module tb_ConstantRegisterV2;

reg  [7:0] tb_MemData;
reg        tb_a_main_n;
reg        tb_load;
wire [7:0] tb_MainBus;

localparam period = 10; // period is 10 nanoseconds

    ConstantRegisterV2  DUT (
        .MemData(tb_MemData),
        .MainBus(tb_MainBus),
        .a_main_n(tb_a_main_n),
        .load(tb_load)
    );
    
    initial
    begin
        tb_MemData =  8'h0;
        tb_a_main_n = 1;
        tb_load =     0;
        #period; // wait

        tb_MemData =  8'hFF;
        tb_a_main_n = 1;
        tb_load =     0;
        #period;

        tb_MemData =  8'hAA;
        tb_a_main_n = 1;
        tb_load =     0;
        #period;

        tb_MemData =  8'hAA;
        tb_a_main_n = 1;
        tb_load =     1;
        #period;
        
        tb_MemData =  8'hAA;
        tb_a_main_n = 1;
        tb_load =     0;
        #period;
        
        tb_MemData =  8'h00;
        tb_a_main_n = 1;
        tb_load =     0;
        #period;
        
        tb_MemData =  8'h00;
        tb_a_main_n = 0;
        tb_load =     0;
        #period;
        
        tb_MemData =  8'h55;
        tb_a_main_n = 0;
        tb_load =     0;
        #period;
        
        tb_MemData =  8'h55;
        tb_a_main_n = 1;
        tb_load =     0;
        #period;
        
        tb_MemData =  8'h55;
        tb_a_main_n = 1;
        tb_load =     1;
        #period;
        
        tb_MemData =  8'h55;
        tb_a_main_n = 1;
        tb_load =     0;
        #period;
        
        tb_MemData =  8'h55;
        tb_a_main_n = 0;
        tb_load =     0;
        #period;
        
        tb_MemData =  8'h55;
        tb_a_main_n = 1;
        tb_load =     0;
        #period;
        
        $finish;
    end
endmodule // end testbench