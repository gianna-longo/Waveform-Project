`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2026 05:22:13 PM
// Design Name: 
// Module Name: template_rom
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

module template_rom
#(
    parameter W = 32
)
(
    input wire [$clog2(W)-1:0] addr,
    output reg signed [15:0] data
);

reg signed [15:0] rom [0:W-1];

initial
begin
    $readmemh("template_l.mem", rom);
end

always @(*)
    data = rom[addr];

endmodule