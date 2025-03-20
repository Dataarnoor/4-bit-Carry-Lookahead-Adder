# 4-bit Carry-Lookahead Adder

## Project Overview
The **4-bit Carry-Lookahead Adder (CLA)** is a high-speed arithmetic circuit designed for efficient binary addition by reducing the propagation delay associated with traditional ripple-carry adders. This project was built entirely from scratch, including **gate-level implementations using Magic VLSI**, as well as netlist-based **circuit simulation and testing**.

## Features
- **Gate-Level Design**: Implemented using fundamental logic gates (AND, OR, XOR, etc.) in **Magic VLSI**.
- **Optimized Carry Computation**: Reduces the delay caused by ripple-carry propagation.
- **Netlist Generation & Simulation**: Created and tested using **NGSPICE** for accurate circuit verification.
- **Functional Verification**: Compared against expected outputs for correctness.
- **Scalability**: The design principles can be extended to create adders of larger bit-widths.

## Tools & Technologies Used
- **Magic VLSI**: For designing the gate-level layout of the adder.
- **NGSPICE**: For netlist-based circuit simulation and validation.
- **Verilog**: To model and test the logical behavior of the adder.
- **Linux Shell Scripting**: For automating netlist simulations.

## Project Breakdown
### 1. Gate-Level Implementation
- Designed the fundamental **AND, OR, XOR, and NOT** gates in **Magic VLSI**.
- Constructed **half-adder** and **full-adder** circuits as building blocks.
- Implemented the **carry-lookahead logic** to efficiently compute carry bits.

### 2. Carry-Lookahead Logic
The **carry-lookahead adder** works by computing the carry bits in advance using the following equations:

- **Generate (G) and Propagate (P) signals**:
  - \( G_i = A_i \cdot B_i \)
  - \( P_i = A_i \oplus B_i \)

- **Carry Computation**:
  - \( C_0 = InputCarry \)
  - \( C_1 = G_0 + (P_0 \cdot C_0) \)
  - \( C_2 = G_1 + (P_1 \cdot C_1) \)
  - \( C_3 = G_2 + (P_2 \cdot C_2) \)
  - \( C_4 = G_3 + (P_3 \cdot C_3) \)

- **Sum Computation**:
  - \( S_i = P_i \oplus C_{i} \) for \( i = 0,1,2,3 \)

### 3. Layout Design in Magic VLSI
- Designed **individual logic gates** and combined them to form the full adder.
- Connected multiple full adders with the **carry-lookahead logic**.
- Verified **DRC (Design Rule Check) and LVS (Layout vs. Schematic) compliance**.

### 4. Netlist Extraction and Simulation
- Generated **SPICE netlist** from the Magic VLSI layout.
- Simulated using **NGSPICE** to verify functionality.
- Compared results with expected truth table values.

## Results
- The **netlist-based verification** confirmed the correctness of the design.
- The **carry-lookahead logic** significantly improved addition speed compared to a ripple-carry adder.
- The layout passed **design rule checks (DRC) and layout vs. schematic (LVS) validation**.

## How to Run the Project
### 1. Open Magic VLSI and Load the Layout
```sh
magic -T your_technology_file.tech carry_lookahead_adder.mag
```
### 2. Extract Netlist
```sh
extract all
ext2spice carry_lookahead_adder.spice
```
### 3. Simulate Using NGSPICE
```sh
ngspice carry_lookahead_adder.spice
```
### 4. Run Verilog Testbench (Optional)
If using Verilog for functional testing:
```sh
iverilog -o cla_tb carry_lookahead_adder_tb.v
vvp cla_tb
```

## Future Improvements
- Implement **8-bit and 16-bit** versions for wider bit-width operations.
- Optimize the **layout design** for better area and power efficiency.
- Integrate with FPGA-based implementations for real-time testing.

## References
- **Digital Design by Morris Mano** (Adder Circuits)
- **VLSI Design Techniques** (Magic VLSI & NGSPICE)

## Author
**Dataarnoor Singh**  
Email: [dataarnoor.oberoi@students.iiit.ac.in](mailto:dataarnoor.oberoi@students.iiit.ac.in)  
GitHub: [github.com/Dataarnoor](https://github.com/Dataarnoor)

