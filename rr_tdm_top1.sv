`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

/*

Version 2:
    Clock generated via PLL with board clock as reference
    TDM at system clock rate
    each system clock cycle, data source into DSP input rotates
    DPS outputs into top level output port to package pin
    incrementer provides B input to DSP48, increments each system clock cycle

*/

//////////////////////////////////////////////////////////////////////////////////

module rr_tdm_top2(
    input  logic clk,
    input  logic [7:0] din0, din1,
    output logic [15:0] dout
);

    localparam WIDTH      = 8;
    localparam INCR_WIDTH = 8;
    localparam NUM_INPUTS = 2;
    localparam USE_RESET  = 0;
    
    logic clk100m;
    logic locked; // NC
    
    wire [WIDTH-1:0] rr_cands[0:NUM_INPUTS-1];
    assign rr_cands[0] = din0;
    assign rr_cands[1] = din1;
    
    logic [INCR_WIDTH-1:0] incr_val;
    logic      [WIDTH-1:0] rr_mux_data;
    
    clk_wiz_0 mmcm_inst(.clk100m(clk100m),
                                .reset(0), // GND
                                .locked(locked),
                                .clk(clk));
    
    incrementer #(.FINAL_COUNT(INCR_WIDTH**2-1),
                  .USE_RESET(USE_RESET))
                 incr_inst (.clk(clk100m),
                            .rst(0),
                            .dout(incr_val));
    
    round_robin_mux #(.DATA_WIDTH(WIDTH),
                      .MUX_DEPTH(NUM_INPUTS),
                      .USE_RESET(USE_RESET))
                     rrmux0 (.clk(clk100m),
                             .rst(0),
                             .candidates(rr_cands),
                             .selected_data(rr_mux_data));
                            
    mult #(.WIDTH_A(WIDTH),
           .WIDTH_B(INCR_WIDTH))
          mult_inst (.clk(clk),
                     .din_a(rr_mux_data),
                     .din_b(incr_val),
                     .dout_p(dout));
    
endmodule