`default_nettype none
module top(
    input wire clk,
    output wire [7:0] pmod1,
    output wire [7:0] pmod2,
    output wire [7:0] pmod3,
    output wire [7:0] pmod4,
    output wire [7:0] pmod5,
    output wire [7:0] pmod6,
    output wire gp6, gp12, gp13, gp14, gp15, gp16, ce1,
    output wire led1, led2,
//    output wire spi_clk, // Can't do this - see below for spi clock pin control.
    output wire spi_cs,
    output wire [3:0] spi_sdio,
    input wire button1, button2

);

    localparam CLK_SPEED = 240_000;
    localparam CLK_W = $clog2(CLK_SPEED);
    reg [CLK_W-1:0] counter = 0;
    reg blink = 0;
    reg [47:0] shift = 48'b1;

    always @(posedge clk) begin
        counter <= counter + 1;
        if(counter == CLK_SPEED - 1) begin
            counter <= 0;  
            blink <= !blink;
            shift <= {shift[0], shift[47:1]};
        end
    end

    // flash all the pmods in sequence
    assign pmod1 = shift[7:0];
    assign pmod2 = shift[15:8];
    assign pmod3 = shift[23:16];
    assign pmod4 = shift[31:24];
    assign pmod5 = shift[39:32];
    assign pmod6 = shift[47:40];

    // blink all the gpios
    assign gp6  = blink;
    assign gp12 = blink;
    assign gp13 = blink;
    assign gp14 = blink;
    assign gp15 = blink;
    assign gp16 = blink;

    assign ce1  = blink;

    assign led1 = button1;
    assign led2 = button2;

    // https://github.com/ironsteel/nes_ecp5/blob/master/top.v#L70
    // the spi clock pin is not available in the lpf file, have to use the USRMCLK primitive
    wire spi_clk = blink;
    wire tristate = 1'b0;
    USRMCLK u1 (.USRMCLKI(spi_clk), .USRMCLKTS(tristate));

    assign spi_sdio = blink ? 4'b1111 : 4'b0000;
    assign spi_cs   = blink;

endmodule
