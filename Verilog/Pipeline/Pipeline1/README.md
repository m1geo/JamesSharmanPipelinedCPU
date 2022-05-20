# James Sharman Pipelined CPU in Verilog
## Pipeline Stage 1 (ALU Dispatch, XFER Bus, Reg Dec)
Pipeline 1. ALU Dispatch, Transfer Bus Control, Register Decrement.

![Simulation Waveform](https://raw.githubusercontent.com/m1geo/JamesSharmanPipelinedCPU/main/Verilog/Pipeline/Pipeline1/PipelineStage1_sim.png "Simulation Waveform")

This module requires binary ROM files from James Sharman to be converted into MEM format (for Verilog import). The bin2mem.py file does this, but has little to no error checking, so use with caution; for example: "python3 bin2mem.py Pipe1A.bin"