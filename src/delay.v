`timescale 1ns / 1ps

module delay #(
    parameter clk_count = 22000000 - 1
) (
    input wire clk,
    input wire reset,
    input wire [15:0] sw,
    input wire [15:0] fifo_in,
    
    output wire [15:0] fifo_out,
    output wire out_valid
    
);

    reg [31:0] counter  = 0;
    
    always @(posedge clk) begin 
        if (reset) begin 
            counter = 0;
            fifo_out <= 0;
        end
        if (counter == clk_count) begin
            fifo_out <= fifo_in;
        end
        else begin
            counter <= counter + 1;
        
endmodule
