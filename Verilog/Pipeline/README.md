# James Sharman Pipelined CPU in Verilog
## Pipeline
This simple module combines the 3 smaller Pipeline stages into a single stage, and squashes the Flag inputs and Control outputs into smaller buses.

See the individual stages for more details on each.

### Pipeline Stage 0
- Fetch
- PC/RA increment 

### Pipeline Stage 1
- ALU dispatch
- 16bit transfer bus control
- 16bit registers (SP, SI, DI) control
- Constant register load

### Pipeline Stage 2
- ALU complete
- 8bit main bus control
- Memory operations
- SP decrement

### Simulation
![Simulation Waveform](https://raw.githubusercontent.com/m1geo/JamesSharmanPipelinedCPU/main/Verilog/Pipeline/PipelineAll_sim.png "Simulation Waveform")