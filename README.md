# Waveform-Project
This project implements a real-time FPGA trigger system for waveform data. The system detects peaks above a threshold, identifies two peaks within a time window, performs template matching using a Gaussian/Landau model, and issues a final trigger signal. The trigger pipeline is visualized using LEDs on a Xilinx Nexys Video FPGA board.

Many detector systems require real-time event selection based on waveform features. This project demonstrates a simplified FPGA  trigger chain similar to those used in particle detectors and radiation instrumentation. The FPGA processes streaming waveform samples and identifies candidate events using peak detection, coincidence logic, and template matching.

Repo Nevigation:
project/
│
├── verilog/
│   ├── top_peak_trigger.v
│   ├── trigger_system.v
│   ├── peak_detector.v
│   ├── two_peak_window.v
│   ├── template_matcher.v
│   ├── led_trigger_sequence.v
│
├── memory/
│   ├── waveform.mem
│   ├── template.mem
│
├── python/
│   ├── generate_waveform.py
│
├── simulation/
│   ├── tb_trigger_system.v
│
└── constraints/
    ├── nexys_video.xdc

In Vivado: 
Design Sources:
- top_peak_trigger.v
  - waveform_source.v    #streams simulated waveform data from BRAM
  - trigger_system.v      #integrates all trigger logic
      - peak_detector.v      #detects local maxima above threshold
      - two_peak_window.v    #detects two peaks within a defined time window
      - template_matcher.v    #compares waveform to a Gaussian/Landau template
        - template_rom.v
  - led_trigger_sequence.v    #displays trigger pipeline on LEDs
- pulse_stretch.v

Memory Files:
 - template_g.mem (Gussian Fit, adjust within verilog code)
 - template_l.mem (Landau fit)
 - waveform.mem (generated waveform in Python)

Constraints:
 - waveformproject.xdc

Simulation Sources:
 - tb_peak_trigger.v
 - pulse_stretch.v
 - Waveform Configuration File
    - tb_peak_trigger_behav.wcfg
 - Memory File:
    - template_g.mem
    - template_l.mem
    - template_l.mem
    - waveform.mem
    - waveform.mem
  
Hardwre:
Target FPGA: Xilinx Nexys Video
Device: Artix-7 XC7A200T
Clock: 100 MHz onboard oscillator
Outputs: 4 user LEDs used for trigger visualization

LED Output:
| LED  | Meaning                      |
| ---- | ---------------------------- |
| LED1 | peak detected                |
| LED2 | two peaks within time window |
| LED3 | template match               |
| LED0 | final trigger                |

Build Instructions:
1. Open Vivado
2. Open the project (.xpr)
3. Run Synthesis
4. Run Implementation
5. Generate Bitstream
6. Program the Nexys Video board

Simulation:
Vivado behavioral simulation can be used to verify the trigger pipeline. The testbench feeds waveform samples and monitors peak, pair, match, and final trigger signals.
