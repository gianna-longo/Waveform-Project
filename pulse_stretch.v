`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2026 05:23:00 PM
// Design Name: 
// Module Name: pulse_stretch
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


module pulse_stretch(

    input wire clk,
    input wire rst,
    input wire in,
    output wire out

);

reg [25:0] counter;

always @(posedge clk)
begin

if(rst)
    counter <= 0;

else if(in)
    counter <= 26'd50000000;

else if(counter>0)
    counter <= counter-1;

end

assign out = (counter>0);

endmodule