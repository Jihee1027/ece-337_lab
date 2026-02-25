`timescale 1ns / 10ps

module timer (
    input logic clk,
    input logic n_rst,
    input logic enable_timer,
    output logic shift_strobe,
    output logic packet_done
);
    // logic strobe_enable;
    logic clear_all;
    // logic [3:0] strobe_count;
    logic clk_count_enable;
    logic [7:0] extra_count;
    logic [7:0] clk_count;
    logic [7:0] bit_count;
    logic [7:0] unused1;
    logic [7:0] unused2;
    logic unused3;
    logic unused4;
    logic next_shift_strobe;
   
    // always_comb begin : Clear_Logic
    //     clear_all = (~enable_timer) | packet_done;

    // end

    flex_counter clk_counter_enable_counter (
        .clk(clk),
        .n_rst(n_rst),
        .clear(clear_all),
        .count_enable(enable_timer),
        .rollover_val(8'd100),
        .count_out(extra_count),
        .rollover_flag(unused4)
    );

    flex_counter clk_counter (
        .clk(clk),
        .n_rst(n_rst),
        .clear(clear_all),
        .count_enable(clk_count_enable),
        .rollover_val(8'd10),
        .count_out(clk_count),
        .rollover_flag(unused3)
    );

    flex_counter bit_counter (
        .clk(clk),
        .n_rst(n_rst),
        .clear(clear_all),
        .count_enable(shift_strobe),
        .rollover_val(8'd9),
        .count_out(bit_count),
        .rollover_flag(packet_done)
    );

    always_ff @(posedge clk or negedge n_rst) begin
        if (!n_rst) begin
            shift_strobe <= 1'b0;
        end else begin
            shift_strobe <= next_shift_strobe;
        end
    end

    always_comb begin
        clear_all = ~enable_timer;
        clk_count_enable  =  extra_count >= 9;
        next_shift_strobe = clk_count == 4;
        unused1 = extra_count;
        unused2 = bit_count;
    end 
endmodule
