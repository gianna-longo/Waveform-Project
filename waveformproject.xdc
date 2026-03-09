set_property PACKAGE_PIN T14 [get_ports {LED[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {LED[0]}]
set_property PACKAGE_PIN T15 [get_ports {LED[1]}]
set_property PACKAGE_PIN T16 [get_ports {LED[2]}]
set_property PACKAGE_PIN U16 [get_ports {LED[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {LED[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {LED[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {LED[1]}]

## 100 MHz system clock
set_property PACKAGE_PIN R4 [get_ports CLK100MHZ]
set_property IOSTANDARD LVCMOS33 [get_ports CLK100MHZ]
create_clock -period 10.000 -name sys_clk_pin [get_ports CLK100MHZ]



