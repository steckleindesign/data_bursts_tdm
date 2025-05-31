# Already created via MMCM IP sources XDC
#create_clock -name sys_clk_pin -period 83.33 -waveform {0 41.66} [get_ports {clk}];

set_input_delay -clock [get_clocks -of_objects [get_pins dual_sys_mmcm/inst/clk100m]] -min 3   [get_ports din0[*]];
set_input_delay -clock [get_clocks -of_objects [get_pins dual_sys_mmcm/inst/clk100m]] -max 3.5 [get_ports din0[*]];

set_input_delay -clock [get_clocks -of_objects [get_pins dual_sys_mmcm/inst/clk100m180p]] -min 3   [get_ports din1[*]];
set_input_delay -clock [get_clocks -of_objects [get_pins dual_sys_mmcm/inst/clk100m180p]] -max 3.5 [get_ports din1[*]];

set_output_delay -clock [get_clocks -of_objects [get_pins dual_sys_mmcm/inst/clk100m]] -min 0.5 [get_ports dout[*]];
set_output_delay -clock [get_clocks -of_objects [get_pins dual_sys_mmcm/inst/clk100m]] -max 1   [get_ports dout[*]];