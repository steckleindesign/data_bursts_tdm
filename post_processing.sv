`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*
Accepts 2 data inputs coming in @ 100MHz (system clock frequency)
Performs a simple addition of the operands, to result in a single output word
The output word is connected to the top level data output port
Output timing in this design has been tight, so try out different pipeline architectures
*/
//////////////////////////////////////////////////////////////////////////////////

module post_processing(
    input  logic clk,
    input  logic [15:0] din0,
    input  logic [15:0] din1,
    output logic [15:0] dout100m
);

    logic [15:0] data_acc;

    always_ff @(posedge clk) begin
        data_acc <= din0 + din1;
        dout100m <= data_acc;
    end

endmodule
