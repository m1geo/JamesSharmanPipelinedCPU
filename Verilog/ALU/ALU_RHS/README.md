# James Sharman Pipelined CPU in Verilog
## ALU RHS logic Unit
ALU RHS. Logic. Based on 4-to-1 mux with carefully selected inputs:

Functions provided:
- (AC[3:0]=0xC) RHS straight through
- (AC[3:0]=0x3) inverted RHS (for subtraction) 
- (AC[3:0]=0x0) Zero operation
- (AC[3:0]=0xF) 255 output
- (AC[3:0]=0x8) LHS AND RHS
- (AC[3:0]=0xE) LHS OR RHS
- (AC[3:0]=0x6) LHS XOR RHS

![Simulation Waveform](https://raw.githubusercontent.com/m1geo/JamesSharmanPipelinedCPU/main/Verilog/ALU/ALU_RHS/ALU_RHS_sim.png "Simulation Waveform")

A crudely annotated cross check shows the functionality of the AC[3:0] signals to match those [shown in the video](https://youtu.be/pMV_0qT0uY0?t=801).

![Simulation Waveform](https://raw.githubusercontent.com/m1geo/JamesSharmanPipelinedCPU/main/Verilog/ALU/ALU_RHS/ALU_RHS_checked_sim.png "Simulation Waveform")