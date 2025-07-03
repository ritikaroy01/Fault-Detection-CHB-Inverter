# Advanced Fault Detection in CHB Multilevel Inverter using LS-PWM (MATLAB Simulation)

This MATLAB project simulates a **5-level Cascaded H-Bridge (CHB) Multilevel Inverter** controlled using **Level-Shifted Pulse Width Modulation (LS-PWM)**. The simulation introduces an **Open-Circuit (OC) fault** in one of the switches and detects it by analyzing deviations in the output voltage waveform.

---

## 🎯 Objective

- To model a CHB inverter using LS-PWM
- To simulate an open-circuit fault condition
- To detect the fault using voltage deviation analysis

---

## ⚙️ Simulation Details

| Parameter              | Value                |
|------------------------|----------------------|
| DC link voltage (per H-Bridge) | 100 V |
| Switching frequency     | 10 kHz               |
| Modulating frequency    | 50 Hz                |
| Modulating waveform     | Sinusoidal           |
| Carrier waveform        | 4 level-shifted triangular signals |
| Simulation time         | 0.05 seconds         |

---

## 🧪 Fault Scenario

- A fault is **injected into Switch S5** at **t = 0.02s** (open-circuit condition).
- The simulation calculates the deviation of the actual output voltage from the expected voltage.
- A **fault detection flag** is raised when this deviation exceeds a 10% threshold.

---

## 🧠 Code Logic Overview

1. **Carrier & Modulation Generation**:
   - 4 level-shifted triangular carriers for 5-level output
   - 1 sinusoidal modulating waveform

2. **LS-PWM Gate Signal Generation**:
   - Gate signals produced by comparing modulating signal with each carrier

3. **Switch Control & Fault Injection**:
   - Gate signals control 8 switches (S1–S8) in 4 H-bridges
   - `S5` is forced open (0) at 0.02s to simulate fault

4. **Output Voltage Calculation**:
   - Output voltages from each H-bridge are calculated and summed

5. **Fault Detection Logic**:
   - Expected output is calculated assuming no fault
   - Error is computed → if error > 10% of Vdc → fault flag raised

---

## 📊 Output Plots

The simulation generates 3 subplots:

1. **Cascaded Output Voltage**  
   Visualizes how the output waveform behaves during and after the fault.

2. **Voltage Error**  
   Shows the deviation of the actual output from the expected output.

3. **Fault Detection Flag**  
   Displays a binary signal (`1` when fault is detected).

---

## 📁 Files Included

| File                     | Description                                      |
|--------------------------|--------------------------------------------------|
| `fault_detection_lspwm.m`| Main MATLAB script with simulation and plots     |
| `README.md`              | Project documentation                            |

---

## 🧩 Future Improvements

- Introduce short-circuit faults or switch misfiring
- Apply machine learning or fuzzy logic for fault classification
- Extend to real-time Simulink implementation with hardware-in-the-loop

---

## 👩‍💻 Author

**Ritika Roy**  
Electrical & Electronics Engineer | VLSI & Power Electronics Enthusiast  
[GitHub](https://github.com/ritikaroy01) • [LinkedIn](https://www.linkedin.com/in/ritikaroy01)

---

## 📜 License

This project is released under the MIT License for educational and research use.

---

## 🙌 Acknowledgements

Special thanks to the MATLAB and power electronics communities for foundational resources in multilevel inverter modeling and LS-PWM techniques.
