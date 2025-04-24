`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

/*

Version 6:
    3 clocks generated via same PLL with board clock as reference,
        - system clock
        - system clock 180 degree phase shift
        - tdm clock which is 2x frequency of system clock
    TDM at 2x system clock rate
    each TDM clock cycle, data source into DSP input rotates
    DSP pipeline registers utilized, AD regs, B reg, C reg, M reg, P reg
    DSP outputs into FIFO, the FIFO outputs into top level output port to package pin
    incrementer provides B input to DSP48, increments each system clock cycle

*/

//////////////////////////////////////////////////////////////////////////////////

module rr_tdm_top5(
    input  logic        clk,
    input  logic  [7:0] din0, din1,
    output logic [15:0] dout
);

    localparam WIDTH      = 8;
    localparam INCR_WIDTH = 8;
    localparam NUM_INPUTS = 2;
    localparam USE_RESET  = 0;
    
    logic clk100m, clk100m180p, clk200m;
    logic locked; // NC
    
    wire [WIDTH-1:0] rr_cands[0:NUM_INPUTS-1];
    assign rr_cands[0] = din0;
    assign rr_cands[1] = din1;
    
    logic [INCR_WIDTH-1:0] incr_val, decr_val;
    logic      [WIDTH-1:0] rr_mux_data, incr_decr_data;
    
    clk_wiz_1 dual_sys_mmcm(.clk100m(clk100m),
                            .clk100m180p(clk100m180p),
                            .clk200m(clk200m),
                            .reset(0), // GND
                            .locked(locked),
                            .clk(clk));
    
    incrementer #(.FINAL_COUNT(INCR_WIDTH**2-1),
                  .USE_RESET(USE_RESET))
                 incr_inst (.clk(clk100m),
                            .rst(0),
                            .dout(incr_val));
    
    decrementer #(.START_COUNT(INCR_WIDTH**2-1),
                  .USE_RESET(USE_RESET))
                 decr_inst (.clk(clk100m180p),
                            .rst(0),
                            .dout(decr_val));
    
    round_robin_mux #(.DATA_WIDTH(WIDTH),
                      .MUX_DEPTH(2),
                      .USE_RESET(USE_RESET))
                     incr_decr_rr_mux (.clk(clk200m),
                                       .rst(0),
                                       .candidates({incr_val,decr_val}),
                                       .selected_data(incr_decr_data));
                     
    round_robin_mux #(.DATA_WIDTH(WIDTH),
                      .MUX_DEPTH(NUM_INPUTS),
                      .USE_RESET(USE_RESET))
                     rrmux0 (.clk(clk200m),
                             .rst(0),
                             .candidates(rr_cands),
                             .selected_data(rr_mux_data));
    
    mult #(.WIDTH_A(WIDTH),
           .WIDTH_B(INCR_WIDTH))
          mult_inst (.clk(clk200m),
                     .din_a(rr_mux_data),
                     .din_b(incr_decr_data),
                     .dout_p(dout));
    
endmodule