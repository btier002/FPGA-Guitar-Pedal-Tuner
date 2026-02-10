module peak_detector #(
    parameter INDEX_WIDTH = 11, // INDEX_WIDTH must be sufficient to index all FFT bins (e.g., 10 for 1024 points, 11 for 2048)
    parameter WIDTH = 32, // Data width is now 48 bits
    parameter FFT_SIZE = 2048 // Adjust to your specific FFT size (e.g., 1024, 2048, etc.)
    ) (
    input wire clk,
    input wire reset,
    input wire [31:0] fft_magnitude_in, // 48-bit input
    input wire valid_in,                // High when fft_magnitude_in is valid
    input wire frame_start,             // High at the start of a new FFT frame
    output reg [31:0] peak_magnitude_out,
    output reg [INDEX_WIDTH-1:0] peak_index_out,
    output reg peak_valid_out
);

    reg [WIDTH-1:0] max_magnitude;
    reg [INDEX_WIDTH-1:0] max_index;
    reg [INDEX_WIDTH-1:0] bin_counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            max_magnitude <= 0;
            max_index <= 0;
            bin_counter <= 0;
            peak_valid_out <= 0;
        end else begin
            if (frame_start) begin
                // Reset for a new frame
                max_magnitude <= 0;
                max_index <= 0;
                bin_counter <= 0;
                peak_valid_out <= 0;
            end 
            
            if (valid_in) begin
                // Compare current 48-bit magnitude with running maximum
                if (fft_magnitude_in > max_magnitude) begin
                    max_magnitude <= fft_magnitude_in;
                    max_index <= bin_counter;
                end
                
                // Increment bin counter
                bin_counter <= bin_counter + 1;

                // When the last bin is processed, the peak is found for this frame
                if (bin_counter == FFT_SIZE - 1) begin
                    peak_valid_out <= 1;
                    peak_magnitude_out <= max_magnitude; // Output the final peak 48-bit magnitude
                    peak_index_out <= max_index;         // Output the final peak index
                end
            end
        end
    end
endmodule
