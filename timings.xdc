create_clock -add -name sys_clk_pin -period 83.33 -waveform {0 41.66} [get_ports {clk}];

set_input_delay -clock clk100m     -min 1 [get_pins din0[*]] # -clock_fall
set_input_delay -clock clk100m     -max 2 [get_pins din0[*]] # -clock_fall
set_input_delay -clock clk100m180p -min 1 [get_pins din1[*]] # -clock_fall
set_input_delay -clock clk100m180p -max 2 [get_pins din1[*]] # -clock_fall

set_output_delay -clock clk200m    -min 1 [get_pins dout[*]]
set_output_delay -clock clk200m    -max 2 [get_pins dout[*]]