/*

spi clk bodge demo.

* short gp6 to spiclk on the raspberry pi header
* run make prog - this explicitly sets gp6 to be an input before programming, otherwise it will fail
* run make blink - this uses spiclk to blink an FPGA controlled LED

*/
`default_nettype none
module top(
    input wire clk,
    input wire gp13, gp6,
    output wire led1, led2

);
    
    assign led1 = gp13;
    assign led2 = gp6;

endmodule
