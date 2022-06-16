# James Sharman Pipelined CPU in Verilog
## ALU
Merged ALU submodules.

### Simulation

![Simulation Waveform](https://raw.githubusercontent.com/m1geo/JamesSharmanPipelinedCPU/main/Verilog/ALU/ALU_sim.png "Simulation Waveform")

### Operation Summary
Summary of ALU Operations from the Diode Matrix on James' build.

| ALU OP | Control | Operation |
|--------|---------|-----------|
| 00     | h00     | NOP       |
| 01     | h10     | SHL       |
| 02     | h20     | SHR       |
| 03     | h0C     | ADD       |
| 04     | h4C     | ADDC      |
| 05     | h80     | INC       |
| 06     | h40     | INCC      |
| 07     | h83     | SUB       |
| 08     | h43     | SUBB      |
| 09     | h0F     | DEC       |
| 10     | h38     | AND       |
| 11     | h3E     | OR        |
| 12     | h36     | XOR       |
| 13     | h33     | NOT       |
| 14     | h30     | CLC       |
| 15     | h00     | err       |
