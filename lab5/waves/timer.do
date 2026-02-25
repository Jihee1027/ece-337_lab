onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_timer/CLK_PERIOD
add wave -noupdate /tb_timer/clk
add wave -noupdate /tb_timer/n_rst
add wave -noupdate /tb_timer/enable_timer
add wave -noupdate /tb_timer/shift_strobe
add wave -noupdate /tb_timer/packet_done
add wave -noupdate -radix decimal /tb_timer/dut/extra_count
add wave -noupdate /tb_timer/dut/clk_count
add wave -noupdate /tb_timer/dut/shift_strobe
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {45000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 216
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
WaveRestoreZoom {538872018639 ps} {538872477967 ps}
