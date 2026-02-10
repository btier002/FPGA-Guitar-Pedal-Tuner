module frequency_calc #(
    parameter INDEX_WIDTH = 11, //11 for 2048, 10 for 1024
    parameter SAMPLING_RATE_HZ = 44100,
    parameter FFT_SIZE = 2048,
    parameter FRAC_BITS = 12, // Number of bits for the fractional part
    parameter FREQ_WIDTH = INDEX_WIDTH + 16 // Adjust width as needed
    ) (
    input wire clk,
    input wire reset,
    input wire [INDEX_WIDTH-1:0] peak_index_in,
    input wire peak_valid_in,
    output reg [FREQ_WIDTH-1:0] dominant_freq_out,
    output reg freq_out_valid
);


    // The constant (Sampling Rate / FFT Size) will be pre-calculated, scaled up by 2^FRAC_BITS.
    // Fs/N * 2^FRAC_BITS
    localparam FREQ_SCALE_FACTOR = (SAMPLING_RATE_HZ * (1 << FRAC_BITS)) / FFT_SIZE;
    // For 44100 * 4096 / 1024 = 176400 (as an integer constant)

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            dominant_freq_out <= 0;
            freq_out_valid <= 0;
        end else if (peak_valid_in) begin
            // Calculate: Frequency = Index * Scaled_Resolution
            // The result is in Q format (e.g., 16.12 fixed point)
            dominant_freq_out <= peak_index_in * FREQ_SCALE_FACTOR;
            freq_out_valid <= 1;
        end
    end
endmodule
