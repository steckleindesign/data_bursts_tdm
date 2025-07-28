`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////

module data_buffer #(
    parameter DATA_WIDTH = 8
)(
    input  logic                  clk,
    input  logic [DATA_WIDTH-1:0] din,
    output logic [DATA_WIDTH-1:0] dout
);

    always_ff @(posedge clk)
        dout <= din;

endmodule