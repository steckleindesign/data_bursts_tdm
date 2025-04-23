`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////////////

module incrementer #(
    parameter FINAL_COUNT = 255,
    parameter USE_RESET   = 0
)(
    input  logic clk,
    input  logic rst,
    output logic [$clog2(FINAL_COUNT):0] dout // why is dout 6-bit when it should be 8-bit
);

    generate
        if (USE_RESET)
            always_ff @(posedge clk)
                if (rst)
                    dout <= 'b0;
                else
                    dout <= (dout == FINAL_COUNT) ? 'b0 : dout + 1;
        else
            always_ff @(posedge clk)
                dout <= (dout == FINAL_COUNT) ? 'b0 : dout + 1;
    
    endgenerate

endmodule