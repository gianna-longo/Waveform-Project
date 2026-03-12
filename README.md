Overview

This project implements a real-time waveform trigger pipeline on an FPGA. The system processes digitized waveform samples and identifies events based on peak detection, coincidence logic, and template matching.

The design is implemented on a Xilinx Nexys Video FPGA (Artix-7) and demonstrates how detector signals can be processed in hardware with very low latency.

Waveform data used for testing is simulated in Python and loaded into the FPGA as a memory initialization file (.mem). The FPGA then streams this data through the trigger pipeline and visualizes trigger stages using onboard LEDs.

Hardware Platform

Board: Xilinx Nexys Video
FPGA: Artix-7 XC7A200T
Clock: 100 MHz onboard oscillator
Inputs: Simulated waveform samples from BRAM
Outputs: 4 user LEDs used for trigger visualization

--------------------------------------------------------

Trigger Pipeline
1. Waveform Source

Module: waveform_source.v
This module emulates a digitizer streaming waveform samples into the FPGA.

- Samples are stored in Block RAM
- Memory is initialized from waveform.mem
- Each clock cycle outputs one sample

Conceptually:
- BRAM → sample_out → trigger pipeline

The waveform is generated offline using Python.

2. Peak Detector

Module: peak_detector.v
This stage identifies local maxima in the waveform.

A peak is detected when: x2 < x1 > x0
Where:
x2 = previous sample
x1 = current sample
x0 = next sample

Additional conditions:
- Peak must exceed a threshold
- Minimum separation between peaks is enforced (deadtime)

Outputs:

peak_pulse
peak_time

3. Two-Peak Coincidence Window

Module: two_peak_window.v
This stage checks whether two peaks occur within a specified time window.

Procedure:
- Store timestamp of the first peak
- When a second peak occurs:
    Compute time difference
    Δt = peak_time2 − peak_time1

    If
    Δt ≤ WINDOW_LEN

    then
    pair_detected = 1

This implements coincidence detection.

4. Template Matching

Module: template_matcher.v
This stage checks whether the waveform shape matches an expected pulse.

A reference template is stored in:
template.mem

The FPGA computes a correlation score: score += sample × template

After processing the template window:
if score > threshold
    match = true

This approximates a matched filter, commonly used in signal processing.

5. Final Trigger Decision

Module: trigger_system.v
This stage combines the results of previous stages.

Example trigger logic:
final_trigger = pair_detected AND template_match

This indicates a valid event has been detected.

6. LED Visualization

Module: led_trigger_sequence.v
Because the trigger pipeline operates at nanosecond speeds, an LED controller converts the trigger event into a human-visible sequence.

When an event occurs, the LEDs display the trigger pipeline stages:

LED Pattern	Meaning
- 0010	peak detected
- 0110	coincidence detected
- 1110	template match
- 1111	final trigger
- 0000	reset

This produces a visible cascade showing the trigger pipeline.

-----------------------------------------------------

Waveform Generation (Python)

Waveform data used by the FPGA is generated with Python and exported as a memory initialization file (waveform.mem).

The generator simulates detector signals with noise and random event timing.

Sampling Parameters
- Sampling Rate:	1 GS/s
- Event Window:	2 µs
- Samples per Event:	2000
- Total Events:	100
- Total Samples:	200000

Event Probabilities (Can be changed to vary output)
- Single peak:	88%
- Double peak:	10%
- Noise only:	2%

Each event includes:
- Gaussian pulse shape
- Random peak position
- Random peak spacing (for double events)
- Additive noise

The generator produces 100 independent events in one waveform stream, which allows the FPGA trigger to operate on a realistic sequence of signals.

----------------------------------------------

Build Instructions

1. Generate waveform data
- python waveform_generator.py

This produces:
- waveform.mem

2. Open the Vivado project

- project.xpr

- Run the FPGA build flow

  1. Run Synthesis
  2. Run Implementation
  3. Generate Bitstream

3. Program the FPGA

Open Hardware Manager → Program Device

----------------------------------------------

Simulation

Vivado behavioral simulation can be used to verify the trigger pipeline.

The testbench feeds waveform samples into the trigger system and monitors:
- peak_pulse
- pair_detected
- template_match
- final_trigger
