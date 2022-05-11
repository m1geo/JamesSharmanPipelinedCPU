# James Sharman Pipelined CPU in Verilog
## Counter Address Register
Counter/Address Register. 16 bit loadable counter. Load from Bus on falling LOAD_n.
Assert to XFER bus on low a_bus_n. Assert to ADDR bus on low a_addr_n.
Data is intentionally doubly registered, as it is on the schematic.
Inc & Dec rely on triggering from both edges.

![Simulation Waveform](https://raw.githubusercontent.com/m1geo/JamesSharmanPipelinedCPU/main/Verilog/CounterAddressRegister/CounterAddressRegister_sim.png "Simulation Waveform")