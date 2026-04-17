`timescale 1ns / 1ps
`default_nettype none

module axis_volume_controller #(
    parameter DATA_WIDTH = 24
) (
    input wire clk,
    // btn0 removed
    
    // SLAVE
    input  wire [DATA_WIDTH-1:0] s_axis_data,
    input  wire s_axis_valid,
    output wire s_axis_ready,
    input  wire s_axis_last,
    
    // MASTER
    output reg [DATA_WIDTH-1:0] m_axis_data = 'b0,
    output reg m_axis_valid = 1'b0,
    input  wire m_axis_ready,
    output reg m_axis_last = 1'b0
);
    reg [DATA_WIDTH-1:0] data_l, data_r;
    reg [1:0] state = 2'b00;

    // 1. Simplified State Machine
    // This ensures we always move from receiving to sending
    assign s_axis_ready = (state == 2'b00); 

    always @(posedge clk) begin
        case (state)
            2'b00: begin // WAIT FOR DATA
                if (s_axis_valid && s_axis_ready) begin
                    if (!s_axis_last) 
                        data_l <= s_axis_data; // audio_enabled logic removed
                    else begin
                        data_r <= s_axis_data; // audio_enabled logic removed
                        m_axis_valid <= 1'b1;
                        m_axis_last <= 1'b0;
                        m_axis_data <= data_l;
                        state <= 2'b01; // Move to Send Left
                    end
                end
            end

            2'b01: begin // SEND LEFT
                if (m_axis_ready) begin
                    m_axis_data <= data_r;
                    m_axis_last <= 1'b1;
                    state <= 2'b10; // Move to Send Right
                end
            end

            2'b10: begin // SEND RIGHT
                if (m_axis_ready) begin
                    m_axis_valid <= 1'b0;
                    m_axis_last <= 1'b0;
                    state <= 2'b00; // Back to Wait
                end
            end
            
            default: state <= 2'b00;
        endcase
    end
endmodule