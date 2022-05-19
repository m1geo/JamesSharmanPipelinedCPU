# James Sharman Pipelined CPU in Verilog
## ALU LHS Shift Unit
ALU LHS. Shifter with carry. Unused 10th MUX IC bit unimplimted in Verilog.

Shift output bus is expanded in simulation wave view to show how bits are moving. LHS and Shift radix is unsigned decimal (not hex).

![Simulation Waveform](https://raw.githubusercontent.com/m1geo/JamesSharmanPipelinedCPU/main/Verilog/ALU_LHS/ALU_LHS_sim.png "Simulation Waveform")

Changing the PCB jumper to NC_CIn passes through the CarryIn to the CarryOut. Default action (NC_CIr fitted, NC_CIn open) [as per video](https://youtu.be/gAJ1tzGgKNw?t=1248) is to zero the CarryOut in C0 (unchanged) mode.

![Simulation Waveform 2](https://raw.githubusercontent.com/m1geo/JamesSharmanPipelinedCPU/main/Verilog/ALU_LHS/ALU_LHS_CIn_sim.png "Simulation Waveform 2")
