create_clock -add -name sys_clk_pin -period 83.33 -waveform {0 41.66} [get_ports {clk}];

set_input_delay -clock sys_clk_pin -min 1 [get_pins din0[0]] # -clock_fall
set_input_delay -clock sys_clk_pin -min 1 [get_pins din0[1]] # -clock_fall
set_input_delay -clock sys_clk_pin -min 1 [get_pins din0[2]] # -clock_fall
set_input_delay -clock sys_clk_pin -min 1 [get_pins din0[3]] # -clock_fall
set_input_delay -clock sys_clk_pin -min 1 [get_pins din0[4]] # -clock_fall
set_input_delay -clock sys_clk_pin -min 1 [get_pins din0[5]] # -clock_fall
set_input_delay -clock sys_clk_pin -min 1 [get_pins din0[6]] # -clock_fall
set_input_delay -clock sys_clk_pin -min 1 [get_pins din0[7]] # -clock_fall
set_input_delay -clock sys_clk_pin -max 2 [get_pins din0[0]] # -clock_fall
set_input_delay -clock sys_clk_pin -max 2 [get_pins din0[1]] # -clock_fall
set_input_delay -clock sys_clk_pin -max 2 [get_pins din0[2]] # -clock_fall
set_input_delay -clock sys_clk_pin -max 2 [get_pins din0[3]] # -clock_fall
set_input_delay -clock sys_clk_pin -max 2 [get_pins din0[4]] # -clock_fall
set_input_delay -clock sys_clk_pin -max 2 [get_pins din0[5]] # -clock_fall
set_input_delay -clock sys_clk_pin -max 2 [get_pins din0[6]] # -clock_fall
set_input_delay -clock sys_clk_pin -max 2 [get_pins din0[7]] # -clock_fall

set_input_delay -clock sys_clk_pin -min 1 [get_pins din1[0]] # -clock_fall
set_input_delay -clock sys_clk_pin -min 1 [get_pins din1[1]] # -clock_fall
set_input_delay -clock sys_clk_pin -min 1 [get_pins din1[2]] # -clock_fall
set_input_delay -clock sys_clk_pin -min 1 [get_pins din1[3]] # -clock_fall
set_input_delay -clock sys_clk_pin -min 1 [get_pins din1[4]] # -clock_fall
set_input_delay -clock sys_clk_pin -min 1 [get_pins din1[5]] # -clock_fall
set_input_delay -clock sys_clk_pin -min 1 [get_pins din1[6]] # -clock_fall
set_input_delay -clock sys_clk_pin -min 1 [get_pins din1[7]] # -clock_fall
set_input_delay -clock sys_clk_pin -max 2 [get_pins din1[0]] # -clock_fall
set_input_delay -clock sys_clk_pin -max 2 [get_pins din1[1]] # -clock_fall
set_input_delay -clock sys_clk_pin -max 2 [get_pins din1[2]] # -clock_fall
set_input_delay -clock sys_clk_pin -max 2 [get_pins din1[3]] # -clock_fall
set_input_delay -clock sys_clk_pin -max 2 [get_pins din1[4]] # -clock_fall
set_input_delay -clock sys_clk_pin -max 2 [get_pins din1[5]] # -clock_fall
set_input_delay -clock sys_clk_pin -max 2 [get_pins din1[6]] # -clock_fall
set_input_delay -clock sys_clk_pin -max 2 [get_pins din1[7]] # -clock_fall

set_output_delay -clock sys_clk_pin -min 1 [get_pins dout[0]]
set_output_delay -clock sys_clk_pin -min 1 [get_pins dout[1]]
set_output_delay -clock sys_clk_pin -min 1 [get_pins dout[2]]
set_output_delay -clock sys_clk_pin -min 1 [get_pins dout[3]]
set_output_delay -clock sys_clk_pin -min 1 [get_pins dout[4]]
set_output_delay -clock sys_clk_pin -min 1 [get_pins dout[5]]
set_output_delay -clock sys_clk_pin -min 1 [get_pins dout[6]]
set_output_delay -clock sys_clk_pin -min 1 [get_pins dout[7]]
set_output_delay -clock sys_clk_pin -min 1 [get_pins dout[8]]
set_output_delay -clock sys_clk_pin -min 1 [get_pins dout[9]]
set_output_delay -clock sys_clk_pin -min 1 [get_pins dout[10]]
set_output_delay -clock sys_clk_pin -min 1 [get_pins dout[11]]
set_output_delay -clock sys_clk_pin -min 1 [get_pins dout[12]]
set_output_delay -clock sys_clk_pin -min 1 [get_pins dout[13]]
set_output_delay -clock sys_clk_pin -min 1 [get_pins dout[14]]
set_output_delay -clock sys_clk_pin -min 1 [get_pins dout[15]]

set_output_delay -clock sys_clk_pin -max 2 [get_pins dout[0]]
set_output_delay -clock sys_clk_pin -max 2 [get_pins dout[1]]
set_output_delay -clock sys_clk_pin -max 2 [get_pins dout[2]]
set_output_delay -clock sys_clk_pin -max 2 [get_pins dout[3]]
set_output_delay -clock sys_clk_pin -max 2 [get_pins dout[4]]
set_output_delay -clock sys_clk_pin -max 2 [get_pins dout[5]]
set_output_delay -clock sys_clk_pin -max 2 [get_pins dout[6]]
set_output_delay -clock sys_clk_pin -max 2 [get_pins dout[7]]
set_output_delay -clock sys_clk_pin -max 2 [get_pins dout[8]]
set_output_delay -clock sys_clk_pin -max 2 [get_pins dout[9]]
set_output_delay -clock sys_clk_pin -max 2 [get_pins dout[10]]
set_output_delay -clock sys_clk_pin -max 2 [get_pins dout[11]]
set_output_delay -clock sys_clk_pin -max 2 [get_pins dout[12]]
set_output_delay -clock sys_clk_pin -max 2 [get_pins dout[13]]
set_output_delay -clock sys_clk_pin -max 2 [get_pins dout[14]]
set_output_delay -clock sys_clk_pin -max 2 [get_pins dout[15]]