`timescale 1ns / 10ps

module timer (
    input logic clk,
    input logic n_rst,
    input logic enable_timer,
    input logic shift_strobe,
    input logic packet_done
);

    logic clear_all;
    logic [3:0] clk_count;
    logic [3:0] bit_count;

    always_comb begin : Clear_Logic
        clear_all = (~enable_timer) | packet_done;
    end

    flex_counter #(
        .SIZE(4)
    ) clk_counter (
        .clk(clk),
        .n_rst(n_rst),
        .clear(clear_all),
        .count_enable(enable_timer),
        .rollover_val(4'd9),
        .count_out(clk_count),
        .rollover_flag(shift_strobe)
    );

    flex_counter #(
        .SIZE(4)
    ) bit_counter (
        .clk(clk),
        .n_rst(n_rst),
        .clear(clear_all),
        .count_enable(shift_strobe),
        .rollover_val(4'd8),
        .count_out(bit_count),
        .rollover_flag(packet_done)
    );
 
endmodule