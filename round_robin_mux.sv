`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////////////

module round_robin_mux #(
    parameter DATA_WIDTH = 8,
    parameter MUX_DEPTH  = 2,
    parameter USE_RESET  = 0
)(
    input  logic clk,
    input  logic rst, // optional
    input  logic [DATA_WIDTH-1:0] candidates[0:MUX_DEPTH-1],
    output logic [DATA_WIDTH-1:0] selected_data
);

    logic [$clog2(MUX_DEPTH)-1:0] sel = 0; // 0 on power up
    
    generate
        case(USE_RESET)
            0: begin
                always_ff @(posedge clk)
                begin
                    sel <= (sel == MUX_DEPTH-1) ? 'b0 : sel + 1'b1;
                    selected_data <= candidates[sel];
                end
            end
            1: begin
                always_ff @(posedge clk)
                begin
                    if (rst)
                        sel <= 0;
                    else
                    begin
                        sel <= (sel == MUX_DEPTH-1) ? 'b0 : sel + 1'b1;
                        selected_data <= candidates[sel];
                    end
                end
            end
        endcase
    endgenerate

endmodule