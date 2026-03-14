onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Input
add wave -noupdate /tb_apb_subordinate/DUT/clk
add wave -noupdate /tb_apb_subordinate/DUT/n_rst
add wave -noupdate /tb_apb_subordinate/DUT/rx_data
add wave -noupdate /tb_apb_subordinate/DUT/data_ready
add wave -noupdate /tb_apb_subordinate/DUT/overrun_error
add wave -noupdate /tb_apb_subordinate/DUT/framing_error
add wave -noupdate -divider Output
add wave -noupdate -color Yellow /tb_apb_subordinate/DUT/data_read
add wave -noupdate -divider Input
add wave -noupdate /tb_apb_subordinate/DUT/psel
add wave -noupdate /tb_apb_subordinate/DUT/paddr
add wave -noupdate /tb_apb_subordinate/DUT/penable
add wave -noupdate /tb_apb_subordinate/DUT/pwrite
add wave -noupdate /tb_apb_subordinate/DUT/pwdata
add wave -noupdate -divider Output
add wave -noupdate -color Yellow /tb_apb_subordinate/DUT/prdata
add wave -noupdate -color Yellow /tb_apb_subordinate/DUT/psaterr
add wave -noupdate -color Yellow /tb_apb_subordinate/DUT/data_size
add wave -noupdate -color Yellow /tb_apb_subordinate/DUT/bit_period
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {722 ps}
