# James Sharman Pipelined CPU in Verilog
## Main Memory (32k RAM, 32k ROM)
Main Memory for Build. 32k RAM (addr[15]=1), 32k ROM (addr[15]=0).

![Simulation Waveform](https://raw.githubusercontent.com/m1geo/JamesSharmanPipelinedCPU/main/Verilog/MainMemory/MainMemory3232_sim.png "Simulation Waveform")

This module requires binary ROM files from James Sharman to be converted into MEM format (for Verilog import). The bin2mem.py file does this, but has little to no error checking, so use with caution; for example: "python3 bin2mem.py Monitor.bin"