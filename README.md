# Robotics-Fall-Indepedent-Study-2025

Digital Audio Processing using an FPGA
Developed by Beatrix J Tierney, materials provided by Dr. Kevin McCullen, SUNY Plattsburgh Robotics Department
Introduction
	During my 2025 spring semester, I had the opportunity to take the Advanced Digital Design course as required by my major. Going into it, I had good knowledge of electronics, but Verilog was still unheard of until my time in this course. For the final class project, I tried making an FPGA video game by driving a VGA and displaying colored sprite. While the project came to be a difficult process which I had barely managed to complete, it left a desire to continue studying coding in Verilog on a Field Gate Programmable Array. Using the knowledge I had gained, I took on an even greater challenge this semester of fall 2025 as an Independent Study. I have spent the past months developing an electric bass interface and tuner using the FPGA: Basys 3, to then make a digital effects pedal. 
Overview
	The goal of this project is to ultimately achieve a setup where I can apply digital effects onto the digital audio stream to mimic the implementation of a guitar pedal. The foundation is an interface with the I2S2 Pmod chip, which has an ADC and DAC already on the chip. The digital audio stream will use the AXI-Stream Pipeline, and after the signal is multiplied to increase its volume, a Fast Fourier Transform is used to make a bin of size 2048 from the real data stream (the complex data is 16’b0). Once the bin is created, the index of the highest magnitude is found locating the location of the dominant frequency. *All equations provided are in from the Verilog code.
 
AXI-Stream Pipeline
Using the demonstration code for the IS2S Pmod chip provided me with guidelines for adding the rest of my implementation by providing the AXI-stream for the 24-bit audio. To ensure timing is correct for smooth audio output, each word must be put to a packet and every 2 words a new packet begins. Each channel’s data is delayed by one 44.1 KHz clock cycle, once the 2 words are gathered, the packet is fed through the pipeline into the volume controller. Tlast is important to the AXI-stream pipeline due to it being the trigger that determines that end of a current packet and determines Tready to collect another 2-word packet after again another clock cycle.
AXIS_I2S2
	The input signal is fed into the AXIS_I2S2 before any other module due to it being the main driver of the AXI-stream pipeline needed for the rest of the implementation. The data is 24-bit left aligned, but we consider both the input tx and output rx to be a vector of 32-bits to accommodate shifting for the one cycle of the serial clock. The 2-word packet is transmitted through the I2S interface next frame. Each packet is two 3-byte words with left being first then right. 
AXIS_volume_controller
	The output from the previous module will then be into a new module which considers the stream of data, then depending on the number of switches flipped on the board, it multiplies the packet by that value. This means that if zero switches are on, the packet transmitted is also zero, meaning no audio data. The implementation given by the Diligent demo code is not perfect, and has issues with sw_sync specifically, without redoing this module entirely I was unable to get the multiplier to consider values past either 1 or 0. Moving forward to avoid the issues with this implementation, while it works for either on or off, a pre-amp module (perhaps using the AMP2 Pmod chip) would be a better choice especially considering the bass I am using is a passive. However, this module is the core of the rest of the tuner modules, as the tx AXI-stream outputs determine if the packet is ready to be sampled by the Fast Fourier Transform.


Fast Fourier Transform Block Design
 
	Vivado’s Ip catalog includes Fast Fourier Transform the is compatible with the AXI-stream pipeline. An FFT using a sample of length 2048 is a sweet spot for performance and accuracy of the processed audio data and before the data streamed by volume_controller is fed into the FFT, it is fed into the FFT_input module which packs the 2048 sample. The output of this module is fed directly into the block design Fast Fourier Transform and while our signal only has a real part, we truncate the real data to 16-bits (shedding the zeroes provided by volume controller to not mess multiplication) while also feeding in a complex portion which is 16-bit 0 vector. Due to the real-world audio stream, the FFT’s downstream is always high (to always process the packet whenever available), both the real and complex output is then sliced to 16-bits, then multiplied, then added back together to get the output of the butterfly algorithm. 


Peak_detector
Bin Width=Sampling Rate HZ÷Fast Fourier Size
	After our sample is sorted, the peak detection module holds the indexing within a 11-bit vector and increments through each bin then finding the max magnitude within and holding that index. After all the bins are incremented through, the index of the maximum magnitude compared to being greater than the rest of the max magnitudes from each bin is taken as an output by a 32-bit vector. The index it is located is also taken as an output. This data then can be used by the next module to determine the dominant frequency of our audio signal.


Frequency_calculator
	To calculate the dominant frequency, the following equations are necessary:
Dominant Frequency=Peak Index* Frequency Scale Factor
Frequency Scale Factor=(Sampling Rate HZ*(1≪Fractional Bits))÷Fast Fourier Size
Using the previous data opened by the Fast Fourier Transform’s output determined by the peak detection module, still using the AXI-stream pipeline to contain our data, at every clock cycle if the data received is valid, the dominant frequency is calculated. This finally gives us the frequency we will be tuning the bass for (for low E 41 Hz) therefore we are ready to use the seven-segment display and LEDs to relay this information to the user. 
Tuner
 
	Using this table as a guide, integer parameters are created stored the frequency in Hz of each standard tuning string. Like many tuners, we consider if the frequency is valid (from the previous module) then accept if the dominant frequency is within a 2 Hz range by setting all board LEDs low. The left 8 LEDs will be high if the frequency is less than the desired frequency minus 2 Hz, and vice versa for the right 8 LEDs. If the frequency is within this space and not in a “deadzone” the note is then displayed by the seven-segment display using a multiplexer that can be setup for using the second anode for sharp and flat indicators. 

Debugging Strategy
	During the development process, ILAs (Integrated Logic Analyzers) were used to seek errors within the transmission between modules by the AXI-stream pipeline. As mentioned before, Tlast is our trigger for all the data to be considered so it tells us when monitoring the ILA during the bitstream run if all is working (and if it is the SSD and LEDs). ILAs are taken from the Ip catalog which all of course are instantiated within the top-level module. 
Top Level
	The basys 3 board has a 100 MHz system clock while the I2S network needs 22 MHz. In the top level alongside all other instantiations of each module, a clocking wizard is wrapped with its input being the system clock and the output being the desired 22 MHz clock needed for the I2S2 Pmod to function on the slave jumper. The top module uses the AXI-stream inputs and outputs to drive all other modules and wrap the design together. 
This project is still a work in progress; here are images of the interface portion of the code being tested using a physical signal generator (not the Ip core) and a handheld oscilloscope: 


Moving Forward
	I will be continuing this project during winter break, and during the spring semester. The goals of the project remain the same, for short term the priority is to ensure the tuner is functional. Once achieved I will be free to move on designing a pre-amp, then making the digital effects. My knowledge of Verilog hardware programming has greatly improved and so has been ease of use within Vivado. While the project was unable to be compressed and completed into a single semester, my goals of learning digital audio processing with FPGAs have been met. There is still lot more content for me to learn and I am excited for the privilege of continuing my studies in a field that combined two of my most interesting topics, being Computer Science and Music Theory.
Reference Links
https://digilent.com/reference/pmod/pmodi2s2/reference-manual?redirect=1
https://www.nti-audio.com/en/support/know-how/fast-fourier-transform-fft
https://github.com/dannydyl/FPGA-Note-Tuner
https://www.youtube.com/watch?v=5-CR5MRGPJE
https://fpga.mit.edu/videos/2018/team22/report.pdf
https://www.instructables.com/Tuner/


	
