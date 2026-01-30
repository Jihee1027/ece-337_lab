`timescale 1ns / 10ps

module pts_4bit (
    input logic clk, n_rst,
    input logic shift_enable,
    input logic load_enable,
    input logic [3:0] parallel_in,
    output logic serial_out
);

    // DO NOT EDIT THIS BLOCK
    flex_sr #(
        .SIZE(4),
        .MSB_FIRST(0)
    ) CORE (
        .clk(clk),
        .n_rst(n_rst),
        .shift_enable(shift_enable),
        .load_enable(load_enable),
        .serial_in(1'b1),
        .parallel_in(parallel_in),
        .serial_out(serial_out),
        /* verilator lint_off PINCONNECTEMPTY */
        .parallel_out()
        /* verilator lint_on PINCONNECTEMPTY */
    );
    // DO NOT EDIT THIS BLOCK

endmodule

