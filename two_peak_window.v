`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2026 05:20:12 PM
// Design Name: 
// Module Name: two_peak_window
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


module two_peak_window(

    input wire clk,
    input wire rst,

    input wire peak_pulse,
    input wire [31:0] peak_time,

    output reg pair_detected

);

parameter WINDOW = 20;

reg [31:0] first_peak;
reg have_first;

always @(posedge clk)
begin

pair_detected <= 0;

if(rst)
    have_first <= 0;

else if(peak_pulse)
begin

    if(!have_first)
    begin
        first_peak <= peak_time;
        have_first <= 1;
    end

    else
    begin

        if((peak_time-first_peak) <= WINDOW)
            pair_detected <= 1;

        first_peak <= peak_time;

    end

end

end

endmodule
