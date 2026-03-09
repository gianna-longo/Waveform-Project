module trigger_system(

    input wire clk,
    input wire rst,

    input wire sample_valid,
    input wire [13:0] sample_in,

    output wire peak_pulse,
    output wire pair_detected,
    output wire template_match,
    output wire final_trigger

);

parameter THRESH = 200;
parameter WINDOW = 300;

reg [31:0] time_counter;

always @(posedge clk)
begin
    if(rst)
        time_counter <= 0;
    else if(sample_valid)
        time_counter <= time_counter + 1;
end

wire [31:0] peak_time;

peak_detector PEAK(

    .clk(clk),
    .rst(rst),

    .sample_valid(sample_valid),
    .sample_in(sample_in),

    .time_counter(time_counter),

    .peak_pulse(peak_pulse),
    .peak_time(peak_time)

);

two_peak_window WINDOW_CHECK(

    .clk(clk),
    .rst(rst),

    .peak_pulse(peak_pulse),
    .peak_time(peak_time),

    .pair_detected(pair_detected)

);

template_matcher MATCH(

    .clk(clk),
    .rst(rst),

    .start(pair_detected),
    .sample_valid(sample_valid),
    .sample_in(sample_in),

    .match(template_match)

);

assign final_trigger = pair_detected & template_match;

endmodule
