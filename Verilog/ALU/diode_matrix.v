// -----------------------------------------------------------------------------
// Title   : ALU-OP Diode Matrix (ALU/diode_matrix.v)
// Create  : Tue 20 Dec 22:31:49 GMT 2022
//
// Name    : JAM-1 8-bit Pipelined CPU in Verilog
// Author  : George Smart, M1GEO.  https://www.george-smart.co.uk
// GitHub  : https://github.com/m1geo/JamesSharmanPipelinedCPU
// CPU Dsn : James Sharman; Video Series => https://youtu.be/3iHag4k4yEg
//
// Desc.   : ALU instruction is decoded with a diode matrix.
// -----------------------------------------------------------------------------

module diode_matrix
(
    input  [3:0] ALUOP,
    output [3:0] LogicSelect,
    output       ShiftSelectA,
    output       ShiftSelectB,
    output       CarrySelectA,
    output       CarrySelectB
);
	
    reg [7:0] r_temp;
    
    always @ (ALUOP) begin
        case (ALUOP)
            4'h1    : r_temp = 8'h10;
            4'h2    : r_temp = 8'h20;
            4'h3    : r_temp = 8'h0C;
            4'h4    : r_temp = 8'h4C;
            4'h5    : r_temp = 8'h80;
            4'h6    : r_temp = 8'h40;
            4'h7    : r_temp = 8'h83;
            4'h8    : r_temp = 8'h43;
            4'h9    : r_temp = 8'h0F;
            4'hA    : r_temp = 8'h38;
            4'hB    : r_temp = 8'h3E;
            4'hC    : r_temp = 8'h36;
            4'hD    : r_temp = 8'h33;
            default : r_temp = 8'h0;
        endcase
    end
    
    // Assign values
    assign LogicSelect = r_temp[3:0];
    assign ShiftSelectA = r_temp[4];
    assign ShiftSelectB = r_temp[5];
    assign CarrySelectA = r_temp[6];
    assign CarrySelectB = r_temp[7];
    
endmodule //end:diode_matrix
