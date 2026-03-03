`timescale 1ns / 10ps

module pwm #(
    // parameters
    parameter SIZE = 8
) (
    input logic clk, n_rst,
    input logic en,
    input logic inv_a,
    input logic inv_b,
    input logic [SIZE-1:0] top,
    input logic [SIZE-1:0] cc_a,
    input logic [SIZE-1:0] cc_b,
    output logic pwm_a,
    output logic pwm_b
);
    logic pwm_a_next;
    logic pwm_b_next;
    logic [SIZE-1:0] unused_a;
    logic [SIZE-1:0] unused_b;
    logic [SIZE-1:0] top_;
    logic stop_a;
    logic stop_b;
    logic clear;
    logic stop_top;

    assign clear = !en;

    flex_counter #(.SIZE(SIZE)) count_cc_a (
        .clk(clk),
        .n_rst(n_rst),
        .clear(clear),
        .count_enable(en),
        .rollover_val(cc_a),
        .count_out(unused_a),
        .rollover_flag(stop_a)
    );

    flex_counter #(.SIZE(SIZE)) count_cc_b (
        .clk(clk),
        .n_rst(n_rst),
        .clear(clear),
        .count_enable(en),
        .rollover_val(cc_b),
        .count_out(unused_b),
        .rollover_flag(stop_b)
    );
    flex_counter #(.SIZE(SIZE)) count_top (
        .clk(clk),
        .n_rst(n_rst),
        .clear(clear),
        .count_enable(en),
        .rollover_val(top),
        .count_out(top_),
        .rollover_flag(stop_top)
    );

    always_ff @(posedge clk or negedge n_rst) begin
        if (!n_rst) begin
            pwm_a <= 1'b0;
            pwm_b <= 1'b0;
        end else begin
            pwm_a <= pwm_a_next;
            pwm_b <= pwm_b_next;
        end
    end

    always_comb begin
        pwm_a_next = 1'b0;
        pwm_b_next = 1'b0;

        if (en) begin
            if (!inv_a | !inv_b) begin
                if (!stop_a | !stop_b) begin
                    pwm_a_next = 1'b1;
                    pwm_b_next = 1'b1;
                end else begin
                    pwm_a_next = 1'b0;
                    pwm_b_next = 1'b0;
                end
            end
        end
    end
    // logic [SIZE-1:0]pwm_a_next;
    // logic [SIZE-1:0]pwm_b_next;

    // always_ff @(posedge clk or negedge n_rst) begin
    //     if (!n_rst) begin
    //         pwm_a <= {SIZE{1'b0}};
    //         pwm_b <= {SIZE{1'b0}};
    //     end else if (en) begin
    //         pwm_a <= pwm_a_next;
    //         pwm_b <= pwm_b_next;
    //     end
    // end

    // always_comb begin
    //     pwm_a_next = pwm_a;
    //     pwm_b_next = pwm_b;
    //     if (en) begin
    //         if (!inv_a) begin
    //             pwm_a_next = {cc_a[SIZE-1:0]};
    //         end if(!inv_b) begin
    //             pwm_b_next = {cc_b[SIZE-1:0]};
    //         end else begin
    //             pwm_a_next = {top[SIZE-1:0]};
    //             pwm_b_next = {cc_b[SIZE-1:0]};
    //         end
    //     end
    // end

endmodule

