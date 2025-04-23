`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////////////

module sync_fifo #(
    parameter WIDTH = 8,
    parameter DEPTH = 16
)(
    input  logic clk,
    input  logic ren, wen,
    input  logic [WIDTH-1:0] din,
    output logic [WIDTH-1:0] dout
);

    logic full;
    logic empty;
    logic [$clog2(DEPTH):0] raddr, waddr;
    
    logic [WIDTH-1:0] fifo_mem[0:DEPTH-1];
    
    always_ff @(posedge clk)
    begin
        if (wen)
        begin
            fifo_mem[waddr] <= din;
            waddr           <= waddr + 1;
        end
        
        if (ren)
        begin
            raddr <= raddr + 1;
        end
        
        dout <= raddr;
        
        full <= 0;
        if (waddr == raddr + DEPTH)
            full <= 1;
        
        empty <= 0;
        if (raddr == waddr)
            empty <= 0;
    end

endmodule