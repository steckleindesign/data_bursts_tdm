`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

/*
Goal of project:
    Gain experience working with a variety of
    fifos, clocks,and time division multiplexing techniques
    in a dense design.

Overview:
    Have different burst/async fifos feed into some dsps and tdm * ops
*/

//////////////////////////////////////////////////////////////////////////////////

module sync_burst_fifo #(
    parameter WIDTH        = 8,   // 1-byte words
    parameter DEPTH        = 100, // 100 word FIFO depth
    parameter WRCLKFREQMHZ = 10,  // 10MHz write clock
    parameter RDCLKFREQMHZ = 100  // 100MHz read clock
)(
    input  logic wr_clk, rd_clk, // clock are from same PLL
    input  logic rst,            // synchronus reset
    input  logic [WIDTH-1:0] din,
    output logic [WIDTH-1:0] dout
);

    logic [WIDTH-1:0] fifo_mem[0:DEPTH-1];
    
    logic [$clog2(DEPTH)-1:0] wr_cnt, rd_cnt;
    
    wire start_burst; // combinatorial logic
    
    always_ff @(posedge wr_clk)
    begin
        if (rst)
        begin
            wr_cnt <= 0;
            // Resetting fifo mem will cause fabric FDREs to be inferred rather than block RAM
            // fifo_mem <= '{default: 0};
        end
        else
        begin
            fifo_mem[wr_cnt] <= din;
            wr_cnt <= (wr_cnt == DEPTH) ? 0 : wr_cnt + 1;
        end
    end
    
    always_ff @(posedge rd_clk)
    begin
        if (rst)
            rd_cnt <= 0;
        else
            if (start_burst || rd_cnt > 0)
            begin
                dout <= fifo_mem[rd_cnt];
                rd_cnt <= (rd_cnt == DEPTH) ? 0 : rd_cnt + 1;
            end
    end
    
    assign start_burst = (wr_cnt == DEPTH - DEPTH*(WRCLKFREQMHZ/RDCLKFREQMHZ));

endmodule
