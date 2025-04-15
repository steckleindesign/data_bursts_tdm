`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

/*

Version 1:
    Clock comes directly from board, no PLL
    TDM at system clock rate
    each system clock cycle, data source into DSP input rotates
    DPS outputs into top level output port to package pin
    incrementer provides B input to DSP48, increments each system clock cycle

Version 2:
    Clock generated via PLL with board clock as reference
    TDM at system clock rate
    each system clock cycle, data source into DSP input rotates
    DPS outputs into top level output port to package pin
    incrementer provides B input to DSP48, increments each system clock cycle

Version 3:
    2 clocks generated via same PLL with board clock as reference,
        - system clock
        - tdm clock which is 2x frequency of system clock
    TDM at 2x system clock rate
    each TDM clock cycle, data source into DSP input rotates
    DPS outputs into top level output port to package pin
    incrementer provides B input to DSP48, increments each system clock cycle
    
Version 4:
    2 clocks generated via same PLL with board clock as reference,
        - system clock
        - tdm clock which is 2x frequency of system clock
    TDM at 2x system clock rate
    each TDM clock cycle, data source into DSP input rotates
    DPS outputs into FIFO, the FIFO outputs into top level output port to package pin
    incrementer provides B input to DSP48, increments each system clock cycle

*/

//////////////////////////////////////////////////////////////////////////////////

module rr_tdm_top(
    input  logic clk,
    input  logic [7:0] din0, din1,
    output logic [7:0] dout
);

    localparam WIDTH      = 8;
    localparam NUM_INPUTS = 2;
    localparam USE_RESET  = 0;
    
    wire [WIDTH-1:0] rr_cands[0:NUM_INPUTS-1];
    assign rr_cands[0] = din0;
    assign rr_cands[1] = din1;
    
    logic [WIDTH-1:0] incr_val;
    logic [WIDTH-1:0] rr_mux_data;
    
    incrementer #(.FINAL_COUNT(4095),
                  .USE_RESET(USE_RESET))
                 incr_inst (.clk(clk),
                            .rst(0),
                            .dout(incr_val));
    
    round_robin_mux #(.DATA_WIDTH(WIDTH),
                      .MUX_DEPTH(NUM_INPUTS),
                      .USE_RESET(USE_RESET))
                     rrmux0 (.clk(clk),
                             .rst(0),
                             .candidates(rr_cands),
                             .selected_data(rr_mux_data));
                            
    mult #(.WIDTH(WIDTH))
          mult_inst (.clk(clk),
                     .din_a(rr_mux_data),
                     .din_b(incr_val),
                     .dout_p(dout));
    
endmodule