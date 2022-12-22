#!/usr/bin/python

# PROM to Verilog Case file
#  This code is not super robust. It'll work, but doesn't handle errors well.
#
# George Smart, M1GEO.
# https://www.george-smart.co.uk/
# https://github.com/m1geo/JamesSharmanPipelinedCPU

# Only used for command line arguments
import sys

# Mangle filenames from input
if len(sys.argv) != 2:
    print("Please call the script with %s ROMFILE.bin" % (str(sys.argv[0])))
    exit(-1)
in_filename = str(sys.argv[1])

#in_filename = str("Pipe1A.bin")
base_filename = in_filename[:-4] 
out_filename = base_filename + ".v"

# Open input and output files
pipe1a_bin = open(in_filename, "rb") # read in
pipe1a_v = open(out_filename, "w") # write out

dar = []
for x in range(256):
    dar.append(0)

# Write header
HDR="""module pipeline_rom_XX
(
    input         clk,
    input         en, // active high
    input  [14:0] addr;
    output  [7:0] dout;
);

    (*rom_style = "block" *) reg [7:0] d;

    always @ (posedge clk) begin
        if (en)
            case(addr)
                """

FTR="""
            endcase
    end //end:always_posedge_clk
    assign dout = d;
endmodule //end:pipeline_rom_XX
"""

pipe1a_v.write(HDR)

byte = pipe1a_bin.read(1)
addr = 0
linecnt = 1
while byte:
    val = int.from_bytes(byte, "big")
    dar[val] = dar[val] + 1
    pipe1a_v.write("15'h%04X: d <= 8'h%02X;" % (addr, val))        
    if linecnt % 4 == 0:
        pipe1a_v.write("\n                ")
    else:
        pipe1a_v.write(" ")
    byte = pipe1a_bin.read(1)
    addr += 1
    linecnt += 1

pipe1a_v.write(FTR)

pipe1a_bin.close()
pipe1a_v.close()

for x in range(256):
    if dar[x] > 0:
        print("Data %02X: %u" % (x, dar[x]))