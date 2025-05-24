`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*
Accepts single input coming in @ 200MHz from DSP48E1
Clock should also be 200MHz, source synchronous from DSP
Each clk period, the register which the data flows to toggles
The output of the module is both registers
*/
//////////////////////////////////////////////////////////////////////////////////


module funnel_1to2(
    input  logic clk,
    input  logic [15:0] data200m,
    output logic [15:0] dout0,
    output logic [15:0] dout1
);
    
    always_ff @(posedge clk) begin
    
    
    end
    
endmodule
