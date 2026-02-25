`timescale 1ns / 10ps

module rcv_block (
   input logic clk,
   input logic n_rst,
   input logic serial_in,
   input logic data_read,
   output logic [7:0] rx_data,
   output logic data_ready,
   output logic overrun_error,
   output logic framing_error
);
    logic load_buffer;
    logic [7:0] packet_data;
    logic new_packet_detected;
    logic sbc_clear;
    logic sbc_enable;
    logic stop_bit;
    logic packet_done;
    logic enable_timer;
    logic shift_strobe;
    logic sync_out;

    rcu reciver_control_unit(
        .clk(clk),
        .n_rst(n_rst),
        .new_packet_detected(new_packet_detected),
        .packet_done(packet_done),
        .framing_error(framing_error),
        .sbc_clear(sbc_clear),
        .sbc_enable(sbc_enable),
        .load_buffer(load_buffer),
        .enable_timer(enable_timer)
    );

    sr_9bit sr_9bits(
        .clk(clk),
        .n_rst(n_rst),
        .shift_strobe(shift_strobe),
        .serial_in(sync_out),
        .packet_data(packet_data),
        .stop_bit(stop_bit)
    );

    rx_data_buff rx_data_buffs(
        .clk(clk),
        .n_rst(n_rst),
        .load_buffer(load_buffer),
        .packet_data(packet_data),
        .data_read(data_read),
        .rx_data(rx_data),
        .data_ready(data_ready),
        .overrun_error(overrun_error)
    );

    start_bit_det start_bit_dets(
        .clk(clk),
        .n_rst(n_rst),
        .serial_in(serial_in),
        .new_packet_detected(new_packet_detected)
    );

    stop_bit_chk stop_bit_chks(
        .clk(clk),
        .n_rst(n_rst),
        .sbc_clear(sbc_clear),
        .sbc_enable(sbc_enable),
        .stop_bit(stop_bit),
        .framing_error(framing_error)
    );

    timer timers(
        .clk(clk),
        .n_rst(n_rst),
        .enable_timer(enable_timer),
        .shift_strobe(shift_strobe),
        .packet_done(packet_done)
    );

    sync syncs(
        .clk(clk),
        .n_rst(n_rst),
        .async_in(serial_in),
        .sync_out(sync_out)
    );

endmodule

