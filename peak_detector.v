module peak_detector(

    input wire clk,
    input wire rst,

    input wire sample_valid,
    input wire [13:0] sample_in,
    input wire [31:0] time_counter,

    output reg peak_pulse,
    output reg [31:0] peak_time

);

parameter THRESH = 1000;
parameter MIN_SEP = 8;

reg [13:0] x0, x1, x2;
reg [15:0] deadtime;

always @(posedge clk)
begin

    peak_pulse <= 0;

    if(rst)
    begin
        x0 <= 0;
        x1 <= 0;
        x2 <= 0;
        deadtime <= 0;
    end

    else if(sample_valid)
    begin

        // shift samples
        x2 <= x1;
        x1 <= x0;
        x0 <= sample_in;

        // deadtime countdown
        if(deadtime > 0)
            deadtime <= deadtime - 1;

        // peak detection
        if((x2 < x1) && (x1 > x0) && (x1 > THRESH) && (deadtime == 0))
        begin
            peak_pulse <= 1;
            peak_time <= time_counter - 1;
            deadtime <= MIN_SEP;
        end

    end

end

endmodule
