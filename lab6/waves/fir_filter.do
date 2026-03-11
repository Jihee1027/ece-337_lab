onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Input
add wave -noupdate /tb_fir_filter/CLK_PERIOD
add wave -noupdate /tb_fir_filter/clk
add wave -noupdate /tb_fir_filter/n_rst
add wave -noupdate -radix ufixed /tb_fir_filter/sample_data
add wave -noupdate -radix ufixed /tb_fir_filter/fir_coefficient
add wave -noupdate /tb_fir_filter/load_coeff
add wave -noupdate /tb_fir_filter/data_ready
add wave -noupdate /tb_fir_filter/dut/lc
add wave -noupdate /tb_fir_filter/dut/dr
add wave -noupdate -divider Output
add wave -noupdate /tb_fir_filter/one_k_samples
add wave -noupdate /tb_fir_filter/dut/overflow
add wave -noupdate /tb_fir_filter/modwait
add wave -noupdate -radix ufixed /tb_fir_filter/fir_out
add wave -noupdate /tb_fir_filter/dut/outreg_data
add wave -noupdate /tb_fir_filter/err
add wave -noupdate -divider Controller
add wave -noupdate /tb_fir_filter/dut/FIR_controller/cnt_up
add wave -noupdate /tb_fir_filter/dut/op
add wave -noupdate /tb_fir_filter/dut/src1
add wave -noupdate /tb_fir_filter/dut/src2
add wave -noupdate /tb_fir_filter/dut/dest
add wave -noupdate /tb_fir_filter/dut/outreg_data
add wave -noupdate -divider States
add wave -noupdate /tb_fir_filter/dut/FIR_controller/state
add wave -noupdate /tb_fir_filter/dut/FIR_controller/state_next
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {198333 ps} 0}
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
WaveRestoreZoom {0 ps} {892500 ps}
