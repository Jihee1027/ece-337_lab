onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group inputs /tb_rcv_block/CLK_PERIOD
add wave -noupdate -expand -group inputs /tb_rcv_block/clk
add wave -noupdate -expand -group inputs /tb_rcv_block/n_rst
add wave -noupdate -expand -group inputs /tb_rcv_block/serial_in
add wave -noupdate -expand -group inputs /tb_rcv_block/data_read
add wave -noupdate -group outputs -radix binary -childformat {{{/tb_rcv_block/rx_data[7]} -radix binary} {{/tb_rcv_block/rx_data[6]} -radix binary} {{/tb_rcv_block/rx_data[5]} -radix binary} {{/tb_rcv_block/rx_data[4]} -radix binary} {{/tb_rcv_block/rx_data[3]} -radix binary} {{/tb_rcv_block/rx_data[2]} -radix binary} {{/tb_rcv_block/rx_data[1]} -radix binary} {{/tb_rcv_block/rx_data[0]} -radix binary}} -subitemconfig {{/tb_rcv_block/rx_data[7]} {-height 16 -radix binary} {/tb_rcv_block/rx_data[6]} {-height 16 -radix binary} {/tb_rcv_block/rx_data[5]} {-height 16 -radix binary} {/tb_rcv_block/rx_data[4]} {-height 16 -radix binary} {/tb_rcv_block/rx_data[3]} {-height 16 -radix binary} {/tb_rcv_block/rx_data[2]} {-height 16 -radix binary} {/tb_rcv_block/rx_data[1]} {-height 16 -radix binary} {/tb_rcv_block/rx_data[0]} {-height 16 -radix binary}} /tb_rcv_block/rx_data
add wave -noupdate -group outputs /tb_rcv_block/data_ready
add wave -noupdate -group outputs /tb_rcv_block/overrun_error
add wave -noupdate -group outputs /tb_rcv_block/framing_error
add wave -noupdate /tb_rcv_block/DUT/new_packet_detected
add wave -noupdate /tb_rcv_block/DUT/overrun_error
add wave -noupdate /tb_rcv_block/DUT/packet_done
add wave -noupdate -divider RCU
add wave -noupdate /tb_rcv_block/DUT/sbc_clear
add wave -noupdate /tb_rcv_block/DUT/sbc_enable
add wave -noupdate /tb_rcv_block/DUT/load_buffer
add wave -noupdate /tb_rcv_block/DUT/enable_timer
add wave -noupdate -divider Timer
add wave -noupdate /tb_rcv_block/DUT/shift_strobe
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {533348 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 224
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {2028874 ps} {2464270 ps}
