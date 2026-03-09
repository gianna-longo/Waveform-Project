`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2026 03:26:40 PM
// Design Name: 
// Module Name: led_trigger_sequence
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

module led_trigger_sequence(

    input clk,
    input rst,

    input peak,
    input pair,
    input match,
    input final_trigger,

    output reg [3:0] LED

);

parameter STEP_TIME = 10_000_000;  // ~0.1 sec per stage (100MHz clock)

reg [31:0] counter;
reg [2:0] stage;
reg event_latched;

always @(posedge clk) begin

    if (rst) begin
        LED <= 0;
        counter <= 0;
        stage <= 0;
        event_latched <= 0;
    end

    else begin

        // latch when a full trigger occurs
        if (final_trigger && !event_latched) begin
            event_latched <= 1;
            stage <= 0;
            counter <= STEP_TIME;
        end

        if (event_latched) begin

            if (counter > 0)
                counter <= counter - 1;

            else begin
                counter <= STEP_TIME;
                stage <= stage + 1;

                case(stage)

                    0: LED <= 4'b0010; // peak
                    1: LED <= 4'b0110; // pair
                    2: LED <= 4'b1110; // match
                    3: LED <= 4'b1111; // final
                    4: begin
                        LED <= 0;
                        event_latched <= 0;
                    end

                endcase
            end
        end

    end

end

endmodule