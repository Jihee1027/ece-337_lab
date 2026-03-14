`timescale 1ns / 10ps

module timer (
    input logic clk,
    input logic n_rst,
    input logic [3:0] data_size,
    input logic [13:0] bit_period,
    input logic enable_timer,
    output logic shift_strobe,
    output logic packet_done
);
    logic clear_all;
    logic [13:0] clk_count;
    logic [3:0] bit_count;
    logic [13:0] unused1;
    logic [3:0] unused2;

    flex_counter #(.SIZE(14)) clk_counter (
        .clk(clk),
        .n_rst(n_rst),
        .clear(clear_all),
        .count_enable(enable_timer),
        .rollover_val(bit_period),
        .count_out(clk_count),
        .rollover_flag(shift_strobe)
    );

    flex_counter #(.SIZE(4)) bit_counter (
        .clk(clk),
        .n_rst(n_rst),
        .clear(clear_all),
        .count_enable(shift_strobe),
        .rollover_val(data_size),
        .count_out(bit_count),
        .rollover_flag(packet_done)
    );

    always_comb begin
        clear_all = ~enable_timer | packet_done;
        unused1 = clk_count;
        unused2 = bit_count;
    end 
endmodule
