`timescale 1ns / 1ps
`default_nettype none

module audio_sample_bram #(
        parameter DATA_WIDTH = 24,
        parameter ADDR_WIDTH = 10
    ) (
    input wire clk,
    input wire resetn,
    input wire [DATA_WIDTH-1:0] audio_data,
    input wire [ADDR_WIDTH-1:0] addr,
   
    
    
    output reg [DATA_WIDTH-1:0] audio_out
    );
    
    // Tell vivado to infer as block ram
    (* rom_style = "block" *)
    reg [DATA_WIDTH-1:0] rom [0:(2**ADDR_WIDTH)-1];
    
    
    
    
    

endmodule