onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_counter/CLK_PERIOD
add wave -noupdate /tb_counter/clk
add wave -noupdate /tb_counter/n_rst
add wave -noupdate /tb_counter/cnt_up
add wave -noupdate /tb_counter/clear
add wave -noupdate /tb_counter/one_k_samples
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
