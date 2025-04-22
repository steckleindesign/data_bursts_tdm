`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// Goal over clock DSP48E1
// DDR style pos/neg edge clock data launch

//////////////////////////////////////////////////////////////////////////////////

(* use_dsp = "yes" *)
module mult #(
    parameter WIDTH_A = 8,
    parameter WIDTH_B = 8
)(
    input  logic                       clk,
    input  logic         [WIDTH_A-1:0] din_a,
    input  logic         [WIDTH_B-1:0] din_b,
    output logic [WIDTH_A+WIDTH_B-1:0] dout_p
);

    // Dual AD reg and dual B reg 1st register is inferred
    // from registering data in modules providing input data

    logic         [WIDTH_A-1:0] din_a2; // Dual AD reg 2
    logic         [WIDTH_A-1:0] din_b2; // Dual B reg 2
    logic [WIDTH_A+WIDTH_B-1:0] m_data; // M reg

    always_ff @(posedge clk)
    begin
        din_a2 <= din_a;
        din_b2 <= din_b;
        m_data <= $signed(din_a2) * $signed(din_b2);
        dout_p <= m_data;
    end

endmodule