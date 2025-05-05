create_clock -add -name sys_clk_pin -period 83.33 -waveform {0 41.66} [get_ports {clk}];

# Do we need these generated clock constraints or does vivado take care of
# them via auto-generated clocks behind the scenes
create_generated_clock -name sys_clk -source [get_ports clk] [get_clocks clk100m_clk_wiz_1];
# Could do 180deg phase shift here, invert is the same effect?
create_generated_clock -name sys_clk_off180 -source [get_ports clk] [get_clocks clk100m180p_clk_wiz_1] -invert;
create_generated_clock -name tdm_clk -source [get_ports clk] [get_clocks clk200m_clk_wiz_1] -multiply_by 2;

set_input_delay -clock clk100m_clk_wiz_1 -min 1 [get_ports din0[0]]; # -clock_fall
set_input_delay -clock clk100m_clk_wiz_1 -min 1 [get_ports din0[1]]; # -clock_fall
set_input_delay -clock clk100m_clk_wiz_1 -min 1 [get_ports din0[2]]; # -clock_fall
set_input_delay -clock clk100m_clk_wiz_1 -min 1 [get_ports din0[3]]; # -clock_fall
set_input_delay -clock clk100m_clk_wiz_1 -min 1 [get_ports din0[4]]; # -clock_fall
set_input_delay -clock clk100m_clk_wiz_1 -min 1 [get_ports din0[5]]; # -clock_fall
set_input_delay -clock clk100m_clk_wiz_1 -min 1 [get_ports din0[6]]; # -clock_fall
set_input_delay -clock clk100m_clk_wiz_1 -min 1 [get_ports din0[7]]; # -clock_fall
set_input_delay -clock clk100m_clk_wiz_1 -max 2 [get_ports din0[0]]; # -clock_fall
set_input_delay -clock clk100m_clk_wiz_1 -max 2 [get_ports din0[1]]; # -clock_fall
set_input_delay -clock clk100m_clk_wiz_1 -max 2 [get_ports din0[2]]; # -clock_fall
set_input_delay -clock clk100m_clk_wiz_1 -max 2 [get_ports din0[3]]; # -clock_fall
set_input_delay -clock clk100m_clk_wiz_1 -max 2 [get_ports din0[4]]; # -clock_fall
set_input_delay -clock clk100m_clk_wiz_1 -max 2 [get_ports din0[5]]; # -clock_fall
set_input_delay -clock clk100m_clk_wiz_1 -max 2 [get_ports din0[6]]; # -clock_fall
set_input_delay -clock clk100m_clk_wiz_1 -max 2 [get_ports din0[7]]; # -clock_fall

set_input_delay -clock clk100m180p_clk_wiz_1 -min 1 [get_ports din1[0]]; # -clock_fall
set_input_delay -clock clk100m180p_clk_wiz_1 -min 1 [get_ports din1[1]]; # -clock_fall
set_input_delay -clock clk100m180p_clk_wiz_1 -min 1 [get_ports din1[2]]; # -clock_fall
set_input_delay -clock clk100m180p_clk_wiz_1 -min 1 [get_ports din1[3]]; # -clock_fall
set_input_delay -clock clk100m180p_clk_wiz_1 -min 1 [get_ports din1[4]]; # -clock_fall
set_input_delay -clock clk100m180p_clk_wiz_1 -min 1 [get_ports din1[5]]; # -clock_fall
set_input_delay -clock clk100m180p_clk_wiz_1 -min 1 [get_ports din1[6]]; # -clock_fall
set_input_delay -clock clk100m180p_clk_wiz_1 -min 1 [get_ports din1[7]]; # -clock_fall
set_input_delay -clock clk100m180p_clk_wiz_1 -max 2 [get_ports din1[0]]; # -clock_fall
set_input_delay -clock clk100m180p_clk_wiz_1 -max 2 [get_ports din1[1]]; # -clock_fall
set_input_delay -clock clk100m180p_clk_wiz_1 -max 2 [get_ports din1[2]]; # -clock_fall
set_input_delay -clock clk100m180p_clk_wiz_1 -max 2 [get_ports din1[3]]; # -clock_fall
set_input_delay -clock clk100m180p_clk_wiz_1 -max 2 [get_ports din1[4]]; # -clock_fall
set_input_delay -clock clk100m180p_clk_wiz_1 -max 2 [get_ports din1[5]]; # -clock_fall
set_input_delay -clock clk100m180p_clk_wiz_1 -max 2 [get_ports din1[6]]; # -clock_fall
set_input_delay -clock clk100m180p_clk_wiz_1 -max 2 [get_ports din1[7]]; # -clock_fall

set_output_delay -clock clk200m_clk_wiz_1 -min 1 [get_ports dout[0]];
set_output_delay -clock clk200m_clk_wiz_1 -min 1 [get_ports dout[1]];
set_output_delay -clock clk200m_clk_wiz_1 -min 1 [get_ports dout[2]];
set_output_delay -clock clk200m_clk_wiz_1 -min 1 [get_ports dout[3]];
set_output_delay -clock clk200m_clk_wiz_1 -min 1 [get_ports dout[4]];
set_output_delay -clock clk200m_clk_wiz_1 -min 1 [get_ports dout[5]];
set_output_delay -clock clk200m_clk_wiz_1 -min 1 [get_ports dout[6]];
set_output_delay -clock clk200m_clk_wiz_1 -min 1 [get_ports dout[7]];
set_output_delay -clock clk200m_clk_wiz_1 -min 1 [get_ports dout[8]];
set_output_delay -clock clk200m_clk_wiz_1 -min 1 [get_ports dout[9]];
set_output_delay -clock clk200m_clk_wiz_1 -min 1 [get_ports dout[10]];
set_output_delay -clock clk200m_clk_wiz_1 -min 1 [get_ports dout[11]];
set_output_delay -clock clk200m_clk_wiz_1 -min 1 [get_ports dout[12]];
set_output_delay -clock clk200m_clk_wiz_1 -min 1 [get_ports dout[13]];
set_output_delay -clock clk200m_clk_wiz_1 -min 1 [get_ports dout[14]];
set_output_delay -clock clk200m_clk_wiz_1 -min 1 [get_ports dout[15]];

set_output_delay -clock clk200m_clk_wiz_1 -max 2 [get_ports dout[0]];
set_output_delay -clock clk200m_clk_wiz_1 -max 2 [get_ports dout[1]];
set_output_delay -clock clk200m_clk_wiz_1 -max 2 [get_ports dout[2]];
set_output_delay -clock clk200m_clk_wiz_1 -max 2 [get_ports dout[3]];
set_output_delay -clock clk200m_clk_wiz_1 -max 2 [get_ports dout[4]];
set_output_delay -clock clk200m_clk_wiz_1 -max 2 [get_ports dout[5]];
set_output_delay -clock clk200m_clk_wiz_1 -max 2 [get_ports dout[6]];
set_output_delay -clock clk200m_clk_wiz_1 -max 2 [get_ports dout[7]];
set_output_delay -clock clk200m_clk_wiz_1 -max 2 [get_ports dout[8]];
set_output_delay -clock clk200m_clk_wiz_1 -max 2 [get_ports dout[9]];
set_output_delay -clock clk200m_clk_wiz_1 -max 2 [get_ports dout[10]];
set_output_delay -clock clk200m_clk_wiz_1 -max 2 [get_ports dout[11]];
set_output_delay -clock clk200m_clk_wiz_1 -max 2 [get_ports dout[12]];
set_output_delay -clock clk200m_clk_wiz_1 -max 2 [get_ports dout[13]];
set_output_delay -clock clk200m_clk_wiz_1 -max 2 [get_ports dout[14]];
set_output_delay -clock clk200m_clk_wiz_1 -max 2 [get_ports dout[15]];