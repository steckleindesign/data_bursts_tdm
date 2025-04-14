`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////////////

module mult #(
    parameter WIDTH = 8
)(
    input  logic clk,
    input  logic [WIDTH-1:0] din_a, din_b,
    output logic [WIDTH*2-1:0] dout_p
);

    always_ff @(posedge clk)
        dout_p <= $signed(din_a) * $signed(din_b);

endmodule