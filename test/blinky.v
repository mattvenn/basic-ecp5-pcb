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
    //output wire spi_clk,
    output wire spi_cs,
    output wire [3:0] spi_sdio,
    input wire button1, button2

);

    localparam CLK_SPEED = 12_000_000;
    localparam CLK_W = $clog2(CLK_SPEED);
    reg [CLK_W-1:0] counter = 0;
    reg blink = 0;
    always @(posedge clk) begin
        counter <= counter + 1;
        if(counter == CLK_SPEED - 1) begin
            counter <= 0;  
            blink <= !blink;
        end
    end
    assign pmod1 = blink ? 8'hFF : 8'h00;
    assign pmod2 = blink ? 8'hFF : 8'h00;
    assign pmod3 = blink ? 8'hFF : 8'h00;
    assign pmod4 = blink ? 8'hFF : 8'h00;
    assign pmod5 = blink ? 8'hFF : 8'h00;
    assign pmod6 = blink ? 8'hFF : 8'h00;
    assign gp6  = blink;
    assign gp12 = blink;
    assign gp13 = blink;
    assign gp14 = blink;
    assign gp15 = blink;
    assign gp16 = blink;

    assign ce1  = blink;

    assign led1 = button1;
    assign led2 = button2;

//    assign spi_clk  = blink; // this pin fails with my nextpnr - update and check
    assign spi_sdio = blink ? 4'b1111 : 4'b0000;
    assign spi_cs   = blink;

endmodule
