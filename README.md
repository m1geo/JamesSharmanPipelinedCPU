# James Sharman Pipelined CPU in Verilog
**_This project doesn't have any content yet. It's just a collection of notes._** 

It will be an Verilog implementation for FPGA of James Sharman's Pipelined CPU.

Below is a list of useful resources:
- [First video in the series](https://www.youtube.com/watch?v=KEwL2P8IGaA) and there are many, many after it.
- [EasyEDA schematics of the build](https://easyeda.com/weirdboyjim)
- [74-series logic Verilog models](https://github.com/TimRudy/ice-chips-verilog/blob/master/device-index.md)
- [CSCvon8 CrazySmallCPU](https://github.com/DoctorWkt/CSCvon8) project for comparison with Verilog implimentation and [some interesting notes](https://github.com/DoctorWkt/CSCvon8/blob/master/Docs/implementation_notes.md)
  - [Fork of above with extra bits](https://github.com/davidclifford/CSCvon8)

## Design principles
I will try to make things as modular as James has. My ideas would be to model the ICs James uses (or borrow them from [here](https://github.com/TimRudy/ice-chips-verilog/blob/master/device-index.md)) and the build modules for each of the PCBs so the Verilog follows the same hierarchy as the PCBs.

Where possible, clocks should come in from the top level, so that they're easily replaced for different vendors. Will probably target [Xilinx Arty A7 platform](https://www.xilinx.com/products/boards-and-kits/arty.html), but will look into [Lattice MachXO2-7000HE devboard](https://www.latticesemi.com/products/developmentboardsandkits/machxo2breakoutboard) too.

## 74-series ICs Used
To start this, I wanted to scour the design to see what 74-series logic ICs James uses. This list below all have models or something looking likely to be useful:
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

Finally, we'll need some RAM and ROM. James uses the following:
- 28C256 ([model](https://github.com/DoctorWkt/CSCvon8/blob/master/rom.v) - EEPROM 32Kx8 - *will need ROM files*)
- LY62256SL-70LL ([model](https://github.com/DoctorWkt/CSCvon8/blob/master/ram.v) - SRAM 32Kx8)
