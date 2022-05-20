#!/usr/bin/python

# PROM to MEM file for Verilog $readmemh
#  This code is not super robust. It'll work, but doesn't handle errors well.
#
# George Smart, M1GEO.
# https://www.george-smart.co.uk/

# Only used for command line arguments
import sys

# Mangle filenames from input
if len(sys.argv) != 2:
    print("Please call the script with %s ROMFILE.bin" % (str(sys.argv[0])))
    exit(-1)
in_filename = str(sys.argv[1])
out_filename = in_filename[:-3] + "mem"

# Open input and output files
pipe1a_bin = open(in_filename, "rb") # read in
pipe1a_mem = open(out_filename, "w") # write out

byte = pipe1a_bin.read(1)
val = int.from_bytes(byte, "big")
pipe1a_mem.write("%02X\n" % val)
while byte:
    byte = pipe1a_bin.read(1)
    val = int.from_bytes(byte, "big")
    pipe1a_mem.write("%02X\n" % val)

pipe1a_bin.close()
pipe1a_mem.close()
