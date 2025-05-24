`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

/*
    
Final Version:
    3 clocks generated via same PLL with board clock as reference,
        - system clock
        - system clock 180 degree phase shift
        - tdm clock which is 2x frequency of system clock
    TDM at 2x system clock rate
    each TDM clock cycle, data source into DSP input rotates
    Data word inputs fed into input fifo buffer
    Incr/Decr data tied to B input of DSP48E1
    DSP pipeline registers utilized, AD regs, B reg, C reg, M reg, P reg
    DSP outputs into FIFO, the FIFO outputs into top level output port to package pin
    incrementer provides B input to DSP48, increments each system clock cycle

    Fix clock constraints - launch and latch edge use different clocks
    create_generated_clocks command for MMCM clocks?
    Why is timing failing?
    Might need to use a separate IO clock and have async crossings to and from IOBs
    
    Weird long delay from registers after and outside the DSP48
    which drives the dout reg array
    
    Why do the registers get weird names like
    "din_rr_mux/genblk1_0.selected_data_reg[*]_psdsp_*"
    ???
    
    No pins match 'dual_sys_mmcm/inst/clk...' warning
    Must not be found before synthesis, but found after
    synthesis and before implementation
    
    Why these bounds?
    Parameter FINAL_COUNT bound to: 63 - type: integer 
	Parameter USE_RESET bound to: 1 - type: integer
	Parameter START_COUNT bound to: 63 - type: integer
	Parameter DATA_WIDTH bound to: 8 - type: integer 
	Parameter MUX_DEPTH bound to: 2 - type: integer
	
	
    
*/

//////////////////////////////////////////////////////////////////////////////////

module rr_tdm_top(
    input  logic        clk,
    input  logic  [7:0] din0, din1,
    (* IOB = "TRUE" *) output logic [15:0] dout
);

    localparam WIDTH      = 8;
    localparam INCR_WIDTH = 8;
    localparam NUM_INPUTS = 2;
    localparam USE_RESET  = 1;
    
    logic clk100m, clk100m180p, clk200m;
    logic locked; // global reset for much essentially
    logic [INCR_WIDTH-1:0] incr_val, decr_val;
    logic      [WIDTH-1:0] rr_mux_data, incr_decr_data;
    logic      [WIDTH-1:0] din0_buffered, din1_buffered;
    logic      [WIDTH-1:0] mult_dout;
    
    // Consider BUFGCE_DIV to reduce skew?
    // Check if we need a BUFG on the CLKOFBOUT connection to CLKFBIN
    // Seems large setup violtions may be due to IO timings? need to study...
    clk_wiz_1 dual_sys_mmcm(.clk100m(clk100m),
                            .clk100m180p(clk100m180p),
                            .clk200m(clk200m),
                            .reset(0), // GND
                            .locked(locked),
                            .clk(clk));
    
    incrementer #(.FINAL_COUNT(2**INCR_WIDTH-1),
                  .USE_RESET(USE_RESET))
                 incr_inst (.clk(clk100m),
                            .rst(locked),
                            .dout(incr_val));
    
    decrementer #(.START_COUNT(2**INCR_WIDTH-1),
                  .USE_RESET(USE_RESET))
                 decr_inst (.clk(clk100m180p),
                            .rst(locked),
                            .dout(decr_val));
    
    round_robin_mux #(.DATA_WIDTH(WIDTH),
                      .MUX_DEPTH(2),
                      .USE_RESET(USE_RESET))
                     incr_decr_rr_mux (.clk(clk200m),
                                       .rst(locked),
                                       .candidates({incr_val,decr_val}),
                                       .selected_data(incr_decr_data));
    
    fifo_in_buffer #(.DATA_WIDTH(WIDTH))
                    in_fifo_a (.clk(clk100m),
                               .din(din0),
                               .dout(din0_buffered));
                               
    fifo_in_buffer #(.DATA_WIDTH(WIDTH))
                    in_fifo_b (.clk(clk100m180p),
                               .din(din1),
                               .dout(din1_buffered));
    
    round_robin_mux #(.DATA_WIDTH(WIDTH),
                      .MUX_DEPTH(NUM_INPUTS),
                      .USE_RESET(USE_RESET))
                     din_rr_mux (.clk(clk200m),
                                 .rst(locked),
                                 .candidates({din0_buffered,din1_buffered}),
                                 .selected_data(rr_mux_data));
    
    mult #(.WIDTH_A(WIDTH),
           .WIDTH_B(INCR_WIDTH))
          mult_inst (.clk(clk200m),
                     .din_a(rr_mux_data),
                     .din_b(incr_decr_data),
                     .dout_p(mult_dout));
    
    funnnel_2to1 (.clk(clk200m),
                  .data200m(mult_dout),
                  .dout0(),
                  .dout1());
    
    post_processing (.clk(clk100m),
                     .din0(),
                     .din1(),
                     .dout100m(dout));
    
endmodule