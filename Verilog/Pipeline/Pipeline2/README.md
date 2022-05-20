# James Sharman Pipelined CPU in Verilog
## Pipeline Stage 2 (Main Bus, Addr Bus, Ctrl)
Pipeline 2. Main Bus, Address Bus, Control

![Simulation Waveform](https://raw.githubusercontent.com/m1geo/JamesSharmanPipelinedCPU/main/Verilog/Pipeline/Pipeline2/PipelineStage2_sim.png "Simulation Waveform")

This module requires binary ROM files from James Sharman to be converted into MEM format (for Verilog import). The bin2mem.py file does this, but has little to no error checking, so use with caution; for example: "python3 bin2mem.py Pipe2A.bin"