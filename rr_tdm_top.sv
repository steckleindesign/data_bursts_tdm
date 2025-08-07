`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////

module rr_tdm_top(
                       input  logic        clk,
                       
    (* IOB = "TRUE" *) input  logic  [7:0] din0,       din1,
    // (* IOB = "TRUE" *) input  logic        din0_valid, din1_valid,
    (* IOB = "TRUE" *) output logic [16:0] dout
);

    localparam WIDTH      = 8;
    localparam INCR_WIDTH = 8;
    localparam NUM_INPUTS = 2;
    localparam USE_RESET  = 1;
    
    logic clk100m, clk100m180p, clk200m;
    logic locked;
    // Data
    logic       [INCR_WIDTH-1:0] incr_val, decr_val;
    logic            [WIDTH-1:0] rr_mux_data, incr_decr_data;
    logic            [WIDTH-1:0] din0_captured, din1_captured;
    logic            [WIDTH-1:0] din0_buffered, din1_buffered;
    logic [INCR_WIDTH+WIDTH-1:0] mult_dout;
    logic [INCR_WIDTH+WIDTH-1:0] mult_data0_100m, mult_data1_100m;
    
    clk_wiz_1
        dual_sys_mmcm(.clk100m(clk100m),
                      .clk100m180p(clk100m180p),
                      .clk200m(clk200m),
                      .reset(0), // Tied to GND
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
    
    round_robin_mux #(.DATA_WIDTH(INCR_WIDTH),
                      .MUX_DEPTH(2),
                      .USE_RESET(USE_RESET))
        incr_decr_rr_mux (.clk(clk200m),
                          .rst(locked),
                          .candidates({incr_val,decr_val}),
                          .selected_data(incr_decr_data));
    
//    data_capture
//        data_capture_inst (.i_clk(clk200m),
//                           .i_din0(din0),
//                           .i_din1(din1),
//                           .i_din0_valid(din0_valid),
//                           .i_din1_valid(din1_valid),
//                           .o_dout0(din0_captured),
//                           .o_dout1(din1_captured));
    
    // Meet I/O hold timing by
    //  Adjusting the trace lengths on the PCB (increase set_input_delay -min accordingly)
    //  Using IDELAY primitive and setting large enough delay taps
    //  Phase shifting the MMCM 100MHz clocks so data is aligned properly to the latch clock edge
    //      Virtual clock to set a phase shifted capture clock from the virtual launch clock?
    //      Or just set the launch clock to clk input?
    //          In this case the MMCM output clock should not only be 180 phase offset of each other
    //              but also each common mode shifted back from clk so the clocks are aligned with din
    //                  din0 is synchronous with delay with respect to clk rising edge
    //                      din is synchronous with delay with respect to clk falling edge
    //      Is the MMCM output clocks actually phase aligned with the clk input?
    //          Sort of? But its not exact
    
    // IBUF (inbuf) (input buffer) propagation delay seems to range 0.2ns - 1.4ns
    
    data_buffer #(.DATA_WIDTH(WIDTH))
        din_buf_a (.clk(clk100m),
                   .din(din0),
                   .dout(din0_buffered));
    
    data_buffer #(.DATA_WIDTH(WIDTH))
        din_buf_b (.clk(clk100m180p),
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
    
    funnel_1to2 #(.WIDTH(WIDTH+INCR_WIDTH))
        funnel_inst (.clk(clk200m),
                     .data200m(mult_dout),
                     .dout0(mult_data0_100m),
                     .dout1(mult_data1_100m));
    
    post_processing  #(.WIDTH(WIDTH+INCR_WIDTH))
        pproc_inst (.clk(clk100m),
                    .din0(mult_data0_100m),
                    .din1(mult_data1_100m),
                    .dout100m(dout));
    
    // Top level output width is 17 (8 + 8 + 1)
    
    
    // 50MHz system -> 100MHz DSP clocks
    // 100MHz data clocked in, valid data word alternates every edge
    // 100MHz source synchronous clock for capturing data
    
    
    // data valid strobe to indicate if din0 or din1 is valid.
    // We know that the 0 phase offset clock is edge aligned with the fast clock
    // So we know that the din1 valid strobe will be aligned with the 180 offset clock
    
    
endmodule