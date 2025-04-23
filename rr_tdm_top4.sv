`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

/*

Version 4:
    2 clocks generated via same PLL with board clock as reference,
        - system clock
        - tdm clock which is 2x frequency of system clock
    TDM at 2x system clock rate
    each TDM clock cycle, data source into DSP input rotates
    DSP pipeline registers utilized, AD regs, B reg, C reg, M reg, P reg
    incrementer provides B input to DSP48, increments each system clock cycle

*/

//////////////////////////////////////////////////////////////////////////////////

module rr_tdm_top4(
    input  logic        clk,
    input  logic  [7:0] din0, din1,
    output logic [15:0] dout
);

    localparam WIDTH      = 8;
    localparam INCR_WIDTH = 8;
    localparam NUM_INPUTS = 2;
    localparam USE_RESET  = 0;
    
    logic clk50m, clk100m;
    logic locked; // NC
    
    wire [WIDTH-1:0] rr_cands[0:NUM_INPUTS-1];
    assign rr_cands[0] = din0;
    assign rr_cands[1] = din1;
    
    logic [INCR_WIDTH-1:0] incr_val;
    logic      [WIDTH-1:0] rr_mux_data;
    
    dsp_clk_mmcm dsp_mmcm_inst(.clk50m(clk50m),
                               .clk100m(clk100m),
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
          mult_inst (.clk(clk100m),
                     .din_a(rr_mux_data),
                     .din_b(incr_val),
                     .dout_p(dout));
    
endmodule