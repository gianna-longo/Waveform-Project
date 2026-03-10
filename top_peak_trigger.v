module top_peak_trigger(
    input CLK100MHZ,
    output [3:0] LED
);

wire rst;
assign rst = 0;

wire [13:0] sample_in;
wire sample_valid;

wire peak_pulse;
wire pair_detected;
wire template_match;
wire final_trigger;

//////////////////////////////////////////////
// waveform source (Python data stream)

waveform_source SOURCE(

    .clk(CLK100MHZ),
    .rst(rst),

    .sample_out(sample_in),
    .sample_valid(sample_valid)

);

//////////////////////////////////////////////
// trigger system

trigger_system TRIGGER(

    .clk(CLK100MHZ),
    .rst(rst),

    .sample_valid(sample_valid),
    .sample_in(sample_in),

    .peak_pulse(peak_pulse),
    .pair_detected(pair_detected),
    .template_match(template_match),
    .final_trigger(final_trigger)

);
//////////////////////////////////////////////
// LED trigger sequence display

led_trigger_sequence LED_SEQ(

    .clk(CLK100MHZ),
    .rst(rst),

    .peak(peak_pulse),
    .pair(pair_detected),
    .match(template_match),
    .final_trigger(final_trigger),

    .LED(LED)

);
endmodule
