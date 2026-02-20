`timescale 1ns / 10ps

module sr_9bit (
    input logic clk,
    input logic n_rst,
    input logic shift_strobe,
    input logic serial_in,
    output logic [7:0] packet_data,
    output logic stop_bit
);
    logic [8:0] sr_out;
    logic unused;

    flex_sr #(
        .SIZE(9),
        .MSB_FIRST(0)
    ) CORE (
        .clk(clk),
        .n_rst(n_rst),
        .shift_enable(shift_strobe),
        .load_enable(1'b0),
        .serial_in(serial_in),
        .parallel_in('0),
        .serial_out(unused),
        .parallel_out(sr_out)
    );

    assign packet_data = sr_out[7:0];
    assign stop_bit = sr_out[8];

endmodule

