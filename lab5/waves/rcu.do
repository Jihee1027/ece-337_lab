onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider inputs
add wave -noupdate /tb_rcu/clk
add wave -noupdate /tb_rcu/n_rst
add wave -noupdate /tb_rcu/new_packet_detected
add wave -noupdate /tb_rcu/packet_done
add wave -noupdate /tb_rcu/framing_error
add wave -noupdate -divider outputs
add wave -noupdate /tb_rcu/sbc_clear
add wave -noupdate /tb_rcu/sbc_enable
add wave -noupdate /tb_rcu/load_buffer
add wave -noupdate /tb_rcu/enable_timer
add wave -noupdate -divider states
add wave -noupdate /tb_rcu/DUT/state
add wave -noupdate /tb_rcu/DUT/state_next
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {60000 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {60 ns} {92 ns}
