onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Input
add wave -noupdate /tb_stoplight/CLK_PERIOD
add wave -noupdate /tb_stoplight/clk
add wave -noupdate /tb_stoplight/n_rst
add wave -noupdate /tb_stoplight/carstart
add wave -noupdate /tb_stoplight/carstop
add wave -noupdate /tb_stoplight/walkstart
add wave -noupdate /tb_stoplight/walkstop
add wave -noupdate -divider Output
add wave -noupdate /tb_stoplight/rled
add wave -noupdate /tb_stoplight/yled
add wave -noupdate /tb_stoplight/gled
add wave -noupdate -divider States
add wave -noupdate /tb_stoplight/DUT/state
add wave -noupdate /tb_stoplight/DUT/state_next
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
WaveRestoreZoom {0 ps} {1 ns}
