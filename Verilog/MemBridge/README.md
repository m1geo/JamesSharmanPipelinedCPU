# James Sharman Pipelined CPU in Verilog
## Memory Bridge
Memory Bridge. Drives MainBus to MemData when d_membridge_n is low. Drives MemData to MainBus when a_membridge_n is low. Otherwise two buses are high-Z.

![Simulation Waveform](https://raw.githubusercontent.com/m1geo/JamesSharmanPipelinedCPU/main/Verilog/MemBridge/MemBridge_sim.png "Simulation Waveform")