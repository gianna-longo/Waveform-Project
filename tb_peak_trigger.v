`timescale 1ns/1ps

module tb_peak_trigger;

// clock and reset
reg CLK100MHZ;
reg CPU_RESETN;

// LED outputs from top module
wire [3:0] LED;

//======================================
// Instantiate the DUT (Device Under Test)

top_peak_trigger DUT (

    .CLK100MHZ(CLK100MHZ),
    .CPU_RESETN(CPU_RESETN),
    .LED(LED)

);

//======================================
// Clock generation
// 100 MHz clock = 10 ns period

initial begin
    CLK100MHZ = 0;
    forever #5 CLK100MHZ = ~CLK100MHZ;
end

//======================================
// Reset sequence

initial begin

    CPU_RESETN = 0;

    // hold reset for a short time
    #100;

    CPU_RESETN = 1;

end

//======================================
// Simulation runtime

initial begin

    // run simulation long enough to process waveform
    #2000000;

    $finish;

end

//======================================
// Monitor key signals

initial begin

    $display("Time   LED0(trigger) LED1(peak) LED2(pair) LED3(match)");

    $monitor("%t   %b %b %b %b",
        $time,
        LED[0],
        LED[1],
        LED[2],
        LED[3]
    );

end

endmodule
