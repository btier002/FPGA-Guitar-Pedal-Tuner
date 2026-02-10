module fft_input #(
    parameter FFT_SIZE = 2048
)(
    input  wire        clk,
    input  wire        reset,

    // 24-bit signed audio from volume controller
    input  wire [23:0] sample_in,
    input  wire        sample_valid,
    input  wire        sample_ready,   // now an INPUT from top (driven by FFT s_axis_ready)

    // AXIS to FFT (32-bit complex)
    output reg  [31:0] tdata,     // {imag, real}
    output reg         tvalid,
    output reg         tlast,
    input  wire        tready
);

    // Counter for TLAST generation
    reg [$clog2(FFT_SIZE)-1:0] sample_cnt = 0;

    wire [15:0] real_part = sample_in[23:8]; // truncate 24→16
    wire [15:0] imag_part = 16'd0;           // zero imaginary

    always @(posedge clk) begin
        if (!reset) begin
            sample_cnt <= 0;
            tvalid     <= 0;
            tlast      <= 0;
            tdata      <= 32'd0;
        end else begin
            // tvalid follows sample_valid; only forward when FFT ready (sample_ready)
            tvalid <= sample_valid & sample_ready;

            if (sample_valid && sample_ready) begin
                // pack and send to FFT
                tdata <= {imag_part, real_part};

                if (sample_cnt == FFT_SIZE-1) begin
                    tlast <= 1'b1;
                    sample_cnt <= 0;
                end else begin
                    tlast <= 1'b0;
                    sample_cnt <= sample_cnt + 1;
                end
            end else begin
                // if not sending this cycle, keep tlast low
                tlast <= 1'b0;
            end
        end
    end

endmodule
