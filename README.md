# James Sharman's JAM-1 8-bit Pipelined CPU in Verilog (ver2)
***This project is a work in progress!***

It will be an Verilog implementation for FPGA of James Sharman's JAM-1 8-bit Pipelined CPU.
Below is a list of useful resources:
- [First video in the series](https://www.youtube.com/watch?v=KEwL2P8IGaA) and there are many, many after it.
- [EasyEDA schematics of the build](https://easyeda.com/weirdboyjim)

The scope of this codebase has changed a little. Initially I was hoping to throw something together quickly but I have since firmed up my requirements. 
The code here is a mix of synchronous and aysnchronos logic, and is not really suited to FPGA. I will, if life permits, attempt to port this into a fully synchronous desing for FPGA implimentation, likely targeting [Xilinx Arty A7 platform](https://www.xilinx.com/products/boards-and-kits/arty.html) and maybe [Lattice MachXO2-7000HE devboard](https://www.latticesemi.com/products/developmentboardsandkits/machxo2breakoutboard) too.
