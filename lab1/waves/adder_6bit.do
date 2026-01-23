onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_adder_6bit/TEST_DELAY
add wave -noupdate /tb_adder_6bit/a
add wave -noupdate /tb_adder_6bit/b
add wave -noupdate /tb_adder_6bit/carry_in
add wave -noupdate /tb_adder_6bit/sum
add wave -noupdate /tb_adder_6bit/carry_out
add wave -noupdate /tb_adder_6bit/test_inputs
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {12155000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {30483763 ps} {30567764 ps}
