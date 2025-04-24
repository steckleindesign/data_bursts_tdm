`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////////////

module decrementer #(
    parameter START_COUNT = 255,
    parameter USE_RESET   = 0
)(
    input  logic clk, rst,
    output logic [$clog2(START_COUNT):0] dout
);

    logic local_rst;

    generate
        if (USE_RESET)
            always_ff @(posedge clk)
                local_rst <= rst;
        else
            assign local_rst = 0; // GND
    endgenerate
    
    always_ff @(posedge clk)
        if (local_rst)
            dout <= 0;
        else
            dout <= dout == 'b0 ? START_COUNT : dout - 1'b1;

endmodule
