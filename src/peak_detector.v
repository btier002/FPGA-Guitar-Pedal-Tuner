module peak_detector #(
    parameter INDEX_WIDTH = 11, 
    parameter WIDTH = 32, 
    parameter FFT_SIZE = 2048 
) (
    input wire clk,
    input wire reset,
    
    // AXI-Stream Slave Interface (from FFT)
    input wire [WIDTH-1:0] fft_magnitude_in, 
    input wire valid_in,                // This is m_axis_data_tvalid
    output wire fft_ready_out,           // This is m_axis_data_tready
    
    // Frame synchronization (often mapped to tlast or user signal)
    input wire frame_start,             
    
    // Output Interface
    output reg [WIDTH-1:0] peak_magnitude_out,
    output reg [INDEX_WIDTH-1:0] peak_index_out,
    output reg peak_valid_out
);

    reg [WIDTH-1:0] max_magnitude;
    reg [INDEX_WIDTH-1:0] max_index;
    reg [INDEX_WIDTH-1:0] bin_counter;

    // Logic: We are always ready to accept data unless we are in reset
    assign fft_ready_out = !reset;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            max_magnitude <= 0;
            max_index <= 0;
            bin_counter <= 0;
            peak_valid_out <= 0;
            peak_magnitude_out <= 0;
            peak_index_out <= 0;
        end else begin
            // Clear valid pulse from previous frame
            peak_valid_out <= 0;

            if (frame_start && valid_in) begin
                max_magnitude <= 0;
                max_index <= 0;
                bin_counter <= 0;
            end 
            
            // Standard AXI handshake: valid high AND ready high
            if (valid_in && fft_ready_out) begin
                if (fft_magnitude_in > max_magnitude) begin
                    max_magnitude <= fft_magnitude_in;
                    max_index <= bin_counter;
                end
                
                bin_counter <= bin_counter + 1;

                if (bin_counter == FFT_SIZE - 1) begin
                    peak_valid_out <= 1;
                    peak_magnitude_out <= (fft_magnitude_in > max_magnitude) ? fft_magnitude_in : max_magnitude;
                    peak_index_out <= (fft_magnitude_in > max_magnitude) ? bin_counter : max_index;
                    bin_counter <= 0; // Reset counter for next frame
                end
            end
        end
    end
endmodule