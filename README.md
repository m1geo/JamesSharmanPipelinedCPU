# James Sharman 8-bit Pipelined CPU in Verilog
***This project doesn't work yet. It's a work in progress.***

It will be an Verilog implementation for FPGA of James Sharman's 8-bit Pipelined CPU.
Below is a list of useful resources:
- [First video in the series](https://www.youtube.com/watch?v=KEwL2P8IGaA) and there are many, many after it.
- [EasyEDA schematics of the build](https://easyeda.com/weirdboyjim)
- [74-series logic Verilog models](https://github.com/TimRudy/ice-chips-verilog/blob/master/device-index.md)
- [CSCvon8 CrazySmallCPU](https://github.com/DoctorWkt/CSCvon8) project for comparison with Verilog implimentation and [some interesting notes](https://github.com/DoctorWkt/CSCvon8/blob/master/Docs/implementation_notes.md)
  - [Fork of above with extra bits](https://github.com/davidclifford/CSCvon8)

## Design principles
Rather than model the design chip-by-chip, I have decided to replicate the functionality of each board in Verilog. Of course, all of the LEDs have been removed. They were the best bit!

Probably target [Xilinx Arty A7 platform](https://www.xilinx.com/products/boards-and-kits/arty.html), and will look into [Lattice MachXO2-7000HE devboard](https://www.latticesemi.com/products/developmentboardsandkits/machxo2breakoutboard) too.

## Useful References (Datasheets & Verilog)
To start this, I wanted to scour the design to see what 74-series logic ICs James uses:
- 74HCT00 (Quad 2-input NAND gate)
- 74HCT04 (Hex inverter)
- 74HCT08 (Quad 2-input AND gate)
- 74HCT138 (3-line to 8-line decoder/demultiplexer (inverted outputs))
- 74HCT153 (Dual 4-input multiplexer)
- 74HCT157 (Quad 2-input multiplexer)
- 74HCT32 (Quad 2-input OR gate)
- 74HCT86 (Quad 2-input XOR gate)
- 74HCT164 ([maybe vhdl?](https://hub.docker.com/r/handskettiso/74164-serialin-parallelout-shift-register-vhdl) - serial input 8-bit edge-triggered shift register [[datasheet](https://assets.nexperia.com/documents/data-sheet/74HC_HCT164.pdf])])
- 74HCT193 ([model](https://github.com/alfishe/74xxx/blob/master/rtl/sn74xxxx.sv) - Presettable synchronous 4-bit binary up/down counter [[datasheet](https://assets.nexperia.com/documents/data-sheet/74HC_HCT193.pdf)])
- 74HCT574 ([model](https://github.com/DoctorWkt/CSCvon8/blob/master/74574.v) - Octal D-type flip-flop; positive edge-trigger; 3-state [[datasheet](https://assets.nexperia.com/documents/data-sheet/74HC_HCT574.pdf)])

The list below are devices used which I do not yet have a model for:
- 74HCT165 (no model - 8-bit serial or parallel-in/serial-out shift register [[datasheet](https://assets.nexperia.com/documents/data-sheet/74HC_HCT165.pdf)])
- 74HCT540 (no model - Octal buffer/line driver; 3-state; inverting [[datasheet](https://assets.nexperia.com/documents/data-sheet/74HC_HCT540.pdf)])
- 74HCT541 (no model - Octal buffer/line driver; 3-state [[datasheet](https://assets.nexperia.com/documents/data-sheet/74HC_HCT541.pdf)])
- 74HCT283 adder

Finally, we'll need some RAM and ROM. James uses the following. James has shared the source files & code:
- 28C256 ([model](https://github.com/DoctorWkt/CSCvon8/blob/master/rom.v) - PROM 32Kx8)
- LY62256SL-70LL ([model](https://github.com/DoctorWkt/CSCvon8/blob/master/ram.v) - SRAM 32Kx8)
