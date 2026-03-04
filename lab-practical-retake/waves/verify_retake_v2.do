onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_verify_retake_v2/CLK_PERIOD
add wave -noupdate -divider Input
add wave -noupdate /tb_verify_retake_v2/clk
add wave -noupdate /tb_verify_retake_v2/n_rst
add wave -noupdate -radix decimal /tb_verify_retake_v2/inc
add wave -noupdate -divider Output
add wave -noupdate -radix decimal /tb_verify_retake_v2/acc
add wave -noupdate /tb_verify_retake_v2/en
add wave -noupdate /tb_verify_retake_v2/clr
add wave -noupdate /tb_verify_retake_v2/min
add wave -noupdate /tb_verify_retake_v2/zro
add wave -noupdate /tb_verify_retake_v2/max
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1074700 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {0 ps} {1144500 ps}
