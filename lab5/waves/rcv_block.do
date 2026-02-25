onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group inputs /tb_rcv_block/CLK_PERIOD
add wave -noupdate -expand -group inputs /tb_rcv_block/clk
add wave -noupdate -expand -group inputs /tb_rcv_block/n_rst
add wave -noupdate -expand -group inputs /tb_rcv_block/serial_in
add wave -noupdate -expand -group inputs /tb_rcv_block/data_read
add wave -noupdate -expand -group outputs -radix binary /tb_rcv_block/rx_data
add wave -noupdate -expand -group outputs /tb_rcv_block/data_ready
add wave -noupdate -expand -group outputs /tb_rcv_block/overrun_error
add wave -noupdate -expand -group outputs /tb_rcv_block/framing_error
add wave -noupdate /tb_rcv_block/DUT/enable_timer
add wave -noupdate /tb_rcv_block/DUT/new_packet_detected
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
WaveRestoreZoom {0 ps} {74083 ps}
