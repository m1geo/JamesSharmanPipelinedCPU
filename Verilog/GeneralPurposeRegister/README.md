# James Sharman Pipelined CPU in Verilog
## GPR Group
The GPR_Group module groups together 4 of the GPRs (named A, B, C and D) into a single module.

## General Purpose Register V1
General Purpose Register V1. Registers MainData on rising LOAD signal. Drives registered value to MainBus, LHS or RHS when ASSERT signal is low.

![Simulation Waveform](https://raw.githubusercontent.com/m1geo/JamesSharmanPipelinedCPU/main/Verilog/GeneralPurposeRegister/GeneralPurposeRegister_sim.png "Simulation Waveform")

## GPR Group
This groups 4 GPR registers together into a group. 

![Simulation Waveform](https://raw.githubusercontent.com/m1geo/JamesSharmanPipelinedCPU/main/Verilog/GeneralPurposeRegister/GPR_Group_sim.png "Simulation Waveform")

