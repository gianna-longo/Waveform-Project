module waveform_source
#(
    parameter N = 20000,      //possible update: I think this should be N=200000
    parameter ADC_WIDTH = 14
)
(
    input wire clk,
    input wire rst,

    output reg [ADC_WIDTH-1:0] sample_out,
    output reg sample_valid
);

reg [ADC_WIDTH-1:0] mem [0:N-1];
reg [$clog2(N)-1:0] index;

initial
begin
    $readmemh("waveform.mem", mem);
end

always @(posedge clk)
begin

    if (rst)
    begin
        index <= 0;
        sample_valid <= 0;
    end

    else
    begin
        sample_out <= mem[index];
        sample_valid <= 1;

        if(index < N-1)
            index <= index + 1;
        else
            index <= 0;

    end

end

endmodule
