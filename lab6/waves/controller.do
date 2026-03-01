onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Input
add wave -noupdate /tb_controller/DUT/clk
add wave -noupdate /tb_controller/DUT/n_rst
add wave -noupdate /tb_controller/DUT/dr
add wave -noupdate /tb_controller/DUT/lc
add wave -noupdate /tb_controller/DUT/overflow
add wave -noupdate -divider Output
add wave -noupdate /tb_controller/DUT/cnt_up
add wave -noupdate /tb_controller/DUT/clear
add wave -noupdate /tb_controller/DUT/modwait
add wave -noupdate /tb_controller/DUT/op
add wave -noupdate -radix unsigned /tb_controller/DUT/src1
add wave -noupdate -radix unsigned /tb_controller/DUT/src2
add wave -noupdate -radix unsigned /tb_controller/DUT/dest
add wave -noupdate /tb_controller/DUT/err
add wave -noupdate -divider State
add wave -noupdate /tb_controller/DUT/state
add wave -noupdate /tb_controller/DUT/state_next
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {614 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 231
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
WaveRestoreZoom {0 ps} {325500 ps}
