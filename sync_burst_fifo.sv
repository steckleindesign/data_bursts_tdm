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
    
    logic wr_cnt, rd_cnt;
    
    logic start_burst; // combinatorial logic
    
    always_ff @(posedge wr_clk)
    begin
        if (rst)
        begin
            wr_cnt <= 0;
            // A reset on fifo mem will cause fabric FDREs to be inferred
            // rather than block mem being inferred
            // fifo_mem <= '{default: 0};
        end
        else
        begin
            if (wr_cnt < DEPTH)
            begin
                fifo_mem[wr_cnt] <= din;
                wr_cnt           <= wr_cnt + 1;
            end
            else
                wr_cnt <= 0;
        end
    end
    
    always_ff @(rd_clk)
    begin
        if (rst)
        begin
            rd_cnt <= 0;
        end
        else
        begin
            if (start_burst || rd_cnt > 0)
            begin
                if (rd_cnt < DEPTH)
                begin
                    dout   <= fifo_mem[rd_cnt];
                    rd_cnt <= rd_cnt + 1;
                end
                else
                    rd_cnt <= 0;
            end 
        end
    end

endmodule
