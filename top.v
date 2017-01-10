`default_nettype none
module top (
	input  clk,
	output LED1,
	output LED2,
	output LED3,
	output LED4,
	output LED5,
    output [7:0] PIO0
);
    wire ddr_clk;

    //PLL details http://www.latticesemi.com/view_document?document_id=47778
    SB_PLL40_CORE #(
        .FEEDBACK_PATH("SIMPLE"),
        .PLLOUT_SELECT("GENCLK"),
        .DIVR(4'b0000),
        .DIVF(7'b1000010),
        .DIVQ(3'b101),
        .FILTER_RANGE(3'b001)
    ) uut (
//        .LOCK(lock),
        .RESETB(1'b1),
        .BYPASS(1'b0),
        .REFERENCECLK(clk),
        .PLLOUTCORE(ddr_clk)
    );

  assign PIO0[2] = clk;
  assign PIO0[3] = ddr_clk;

  ddr ddr_out(.clk(ddr_clk), .ddr_out_p(PIO0[0]), .ddr_out_n(PIO0[1]));

endmodule
