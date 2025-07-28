`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////

module data_capture(
    input   logic       i_ss_clk,
    input   logic [7:0] i_din0,
    input   logic [7:0] i_din1,
    input   logic       i_din0_valid,
    input   logic       i_din1_valid,
    output  logic [7:0] o_dout0,
    output  logic [7:0] o_dout1
);

    // Source synchronous
    always_ff @(posedge i_ss_clk) begin
        if (i_din0_valid)
            o_dout0 <= i_din0;
        if (i_din1_valid)
            o_dout1 <= i_din1;
    end

endmodule