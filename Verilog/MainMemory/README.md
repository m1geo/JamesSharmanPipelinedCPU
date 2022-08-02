# James Sharman Pipelined CPU in Verilog
These modules require binary ROM files from James Sharman to be converted into MEM format (for Verilog import). The ..\..\tools\bin2mem.py file does this, but has little to no error checking, so use with caution; for example: "python3 bin2mem.py Monitor.bin"

## Main Memory (32k RAM, 32k ROM)
Main Memory for Build. 32k RAM (addr[15]=1), 32k ROM (addr[15]=0).

![Simulation Waveform](https://raw.githubusercontent.com/m1geo/JamesSharmanPipelinedCPU/main/Verilog/MainMemory/MainMemory3232_sim.png "Simulation Waveform")

## Main Memory (64k Shadow)
Main Memory for Build. Recommended for use as in James' later build. No copy functionality, since we can use Verilog initial block to preload memory.

![Simulation Waveform](https://raw.githubusercontent.com/m1geo/JamesSharmanPipelinedCPU/main/Verilog/MainMemory/MainMemory64shadow_sim.png "Simulation Waveform")

The 64k Shadow memory passes the same simple testing as the 3232 version (with addition of extra control {Memory_Ack} line as per James' design).