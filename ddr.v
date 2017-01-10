`default_nettype none
module ddr (
	input wire clk,
    output wire ddr_out_p,
    output wire ddr_out_n
);
    reg [7:0] data = 8'b00000101;
    reg [2:0] index = 0;

	always@(posedge clk) begin
        index <= index + 2;
    end

    wire input_0;
    wire input_180;

    assign input_0 = data[index];
    assign input_180 = data[index+1];

    // ddr details: http://www.latticesemi.com/view_document?document_id=47960
    defparam differential_output_b.PIN_TYPE = 6'b010000;
    defparam differential_output_b.IO_STANDARD = "SB_LVCMOS" ;
    SB_IO differential_output_b (
    .PACKAGE_PIN(ddr_out_p),
    .LATCH_INPUT_VALUE (1'b1 ),
    .CLOCK_ENABLE (1'b1  ),
    .INPUT_CLK ( clk ),
    .OUTPUT_CLK ( clk),
    .OUTPUT_ENABLE (1'b1 ),
    .D_OUT_0 (input_0), // Non-inverted
    .D_OUT_1 (input_180), // Non-inverted
    );
    // Inverting, N-side of pair
    defparam differential_output_a.PIN_TYPE = 6'b010000 ;
    defparam differential_output_a.IO_STANDARD = "SB_LVCMOS" ;
    SB_IO differential_output_a (
    .PACKAGE_PIN(ddr_out_n),
    .LATCH_INPUT_VALUE ( 1'b1),
    .CLOCK_ENABLE ( 1'b1),
    .INPUT_CLK ( clk ),
    .OUTPUT_CLK (clk),
    .OUTPUT_ENABLE (1'b1 ),
    .D_OUT_0 (~input_0), // Inverted
    .D_OUT_1 (~input_180), // Inverted
    );

endmodule
