# xc7k70t

# 12MHz board clock
set_property -dict { PACKAGE_PIN L17   IOSTANDARD LVCMOS33 } [get_ports { clk }]; #IO_L12P_T1_MRCC_14 Sch=GCLK

set_property -dict { PACKAGE_PIN H19   IOSTANDARD LVCMOS33 } [get_ports { din0[0] }];
set_property -dict { PACKAGE_PIN G19   IOSTANDARD LVCMOS33 } [get_ports { din0[1] }];
set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { din0[2] }];
set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports { din0[3] }];
set_property -dict { PACKAGE_PIN J19   IOSTANDARD LVCMOS33 } [get_ports { din0[4] }];
set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports { din0[5] }];
set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { din0[6] }];
set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports { din0[7] }];

set_property -dict { PACKAGE_PIN N18   IOSTANDARD LVCMOS33 } [get_ports { din1[0] }];
set_property -dict { PACKAGE_PIN N19   IOSTANDARD LVCMOS33 } [get_ports { din1[1] }];
set_property -dict { PACKAGE_PIN P19   IOSTANDARD LVCMOS33 } [get_ports { din1[2] }];
set_property -dict { PACKAGE_PIN R19   IOSTANDARD LVCMOS33 } [get_ports { din1[3] }];
set_property -dict { PACKAGE_PIN M18   IOSTANDARD LVCMOS33 } [get_ports { din1[4] }];
set_property -dict { PACKAGE_PIN M19   IOSTANDARD LVCMOS33 } [get_ports { din1[5] }];
set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports { din1[6] }];
set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { din1[7] }];

set_property -dict { PACKAGE_PIN P17   IOSTANDARD LVCMOS33 } [get_ports { dout[0] }];
set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports { dout[1] }];
set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports { dout[2] }];
set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports { dout[3] }];
set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports { dout[4] }];
set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports { dout[5] }];
set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { dout[6] }];
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { dout[7] }];
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { dout[8] }];
set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports { dout[9] }];
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports { dout[10] }];
set_property -dict { PACKAGE_PIN W17   IOSTANDARD LVCMOS33 } [get_ports { dout[11] }];
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports { dout[12] }];
set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS33 } [get_ports { dout[13] }];
set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports { dout[14] }];
set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33 } [get_ports { dout[15] }];