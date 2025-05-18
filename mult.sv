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

    logic         [WIDTH_A-1:0] din_a1, din_a2; // Dual AD reg
    logic         [WIDTH_A-1:0] din_b1, din_b2; // Dual  B reg
    logic [WIDTH_A+WIDTH_B-1:0] m_data;         //       M reg
    logic [WIDTH_A+WIDTH_B-1:0] p_data;         //       P reg

    // Prelim mapping report
    // (A''*B'')'
    // A size = 8, B size = 8
    // P size = 16, Areg = 2, Breg = 2, Mreg = 1, Preg = 1
    
    // DSP final report
    // ((A''*B'')')'
    // A size = 30, B size = 7, P size = 16
    // Areg = 2, Breg = 2, Mreg = 1, Preg = 1
    always_ff @(posedge clk)
    begin
        // All regs absorbed into DSP p_data_reg
        din_a1 <= din_a;
        din_b1 <= din_b;
        din_a2 <= din_a1;
        din_b2 <= din_b1;
        // Operator is absorbed into DSP p_data_reg
        m_data <= $signed(din_a2) * $signed(din_b2);
        p_data <= m_data;
        dout_p <= p_data;
    end

endmodule