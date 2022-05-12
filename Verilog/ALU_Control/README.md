# James Sharman Pipelined CPU in Verilog
## ALU Control
ALU Control Register. Diode ROM, 4-to-16 line decoder, inverting buffer.

![Simulation Waveform](https://raw.githubusercontent.com/m1geo/JamesSharmanPipelinedCPU/main/Verilog/ALU_Control/ALU_Control_sim.png "Simulation Waveform")


*Note*: The RTL has a _bufgce_ and _anded_ AluClock output (based on AluActive). The simulation shows a missing cycle on bufgce but is the right way to clock-gate on FPGA. Likely a weirdness in simulation 'perfection'.