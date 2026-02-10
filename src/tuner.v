`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Beatrix Tierney
// 
// Create Date: 11/17/2025 12:33:26 PM
// Design Name: 
// Module Name: tuner
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


module tuner #(
    parameter INDEX_WIDTH = 11,
    parameter FREQ_WIDTH = INDEX_WIDTH + 16
) (
    input wire clk,
    input wire reset,
    input wire [15:0] led,
    input wire [FREQ_WIDTH-1:0] freq_in,
    input wire freq_valid,
    output reg [3:0] an,
    output reg [6:0] seg
    );
    
    //Notes
    parameter B0 = 30; //Extension for 5 string
    parameter D0 = 32;
    parameter DS0 = 37;
    parameter E1 = 41; // E String
    parameter F1 = 44;
    parameter FS1 = 46;
    parameter G1 = 49;
    parameter GS1 = 52;
    parameter A1 = 55; //A String
    parameter AS1 = 58;
    parameter B1 = 62;
    parameter C1 = 65;
    parameter CS1 = 69;
    parameter D1 = 73; // D String
    parameter DS1 = 78;
    parameter E2 = 82;
    parameter F2 = 87;
    parameter FS2 = 92;
    parameter G2 = 98; // G String
    parameter GS2 = 104;
    parameter A2 = 110;
    parameter AS2 = 117;
    parameter B2 = 123;
    parameter C2 = 131;
    parameter CS2 = 139;
    parameter D2 = 147;
    parameter DS2 = 156;
    parameter E3 = 165;
    parameter F3 = 175;
    parameter FS3 = 185;
    parameter G3 = 196;
    parameter GS3 = 208;
    parameter A3 = 220;
    parameter AS3 = 233;
    parameter B3 = 247;
    parameter C3 = 262;
    parameter CS3 = 277;
    parameter D3 = 294;
    parameter DS3 = 311;
    
    //LED Error
    reg [16:0] freq_error;
    
    reg [16:0] refresh_counter;
    wire refresh_tick = (refresh_counter == 124_999); //~800 Hz
    
    reg active_digit; 
    reg [6:0] seg_note;
    
    reg [15:0] led_reg;
    
    //Digit Multiplexing
    //Refresh Counter
    always @(posedge clk) begin
        if(reset)
            refresh_counter <= 0;
        else if (refresh_tick)
            refresh_counter <= 0;
        else
            refresh_counter <= refresh_counter +1;
     end 
     
     //Digit Toggle
     always @(posedge clk) begin
         if (reset)
            active_digit <= 1'b0;
         else if (refresh_tick)
            active_digit <= ~active_digit;     
     end
     
     //Display Note
     always @(*) begin  
        if (freq_valid) begin
            if(freq_in >= (E1-2) && freq_in <= (E1+2)) begin//E within 2HZ
                seg_note = 7'b0000110; //E
                freq_error = freq_in - E1;
            end
            else if(freq_in >= (A1-2) && freq_in <= (A1+2)) begin//E within 2HZ
                seg_note = 7'b0001000; //A    
                freq_error = freq_in - A1;
            end
            else if(freq_in >= (D2-2) && freq_in <= (D2+2)) begin//E within 2HZ
                seg_note = 7'b0100001; //D
                freq_error = freq_in - D2;
            end
            else if(freq_in >= (G2-2) && freq_in <= (G2+2)) begin//E within 2HZ
                seg_note = 7'b0000010; //G
                freq_error = freq_in - G2;
            end
            else begin
                seg_note = 7'b1111111; //NONE
                freq_error = 0;
            end
        end
        else begin
            seg_note = 7'b1111111; //NONE
        end
    end
    
    //Segment Driver
    always @(*) begin
        if (active_digit == 0) begin
            an = 4'b1110; //0
            seg = seg_note;
        end else begin
            an = 4'b1101; //1(Sharps/Flats)
            seg = 7'b1111111;
        end
    end
    
    //LED Driver
    always @(*) begin
        if (~freq_valid) begin
            led_reg = 16'b0; //None
        end
        else if (freq_error > 2) begin
            //Greater than Note
            led_reg = 16'b0000000011111111;
        end else if (freq_error < -2) begin
            //Less than Note
            led_reg = 16'b1111111100000000;
        end
    end
    
    assign led = led_reg;
    
endmodule

