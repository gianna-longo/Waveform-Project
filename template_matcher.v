`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2026 05:21:13 PM
// Design Name: 
// Module Name: template_matcher
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module template_matcher(

    input wire clk,
    input wire rst,

    input wire start,
    input wire sample_valid,
    input wire [13:0] sample_in,

    output reg match

);

parameter W = 32;
parameter SCORE_THR = 1000;

reg [15:0] index;
reg signed [31:0] score;
reg running;

wire signed [15:0] template_val;

template_rom ROM(

    .addr(index),
    .data(template_val)

);

always @(posedge clk)
begin

if(rst)
begin
    running <= 0;
    index <= 0;
    score <= 0;
    match <= 0;
end

else
begin

    if(start)
    begin
        running <= 1;
        index <= 0;
        score <= 0;
    end

    if(running && sample_valid)
    begin

        score <= score + sample_in * template_val;

        if(index == W-1)
        begin
            running <= 0;
            match <= (score > SCORE_THR);
        end

        index <= index + 1;

    end

end

end

endmodule