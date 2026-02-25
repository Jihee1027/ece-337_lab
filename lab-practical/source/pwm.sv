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
    output logic [SIZE-1:0] pwm_a,
    output logic [SIZE-1:0] pwm_b
);
    logic [SIZE-1:0]pwm_a_next;
    logic [SIZE-1:0]pwm_b_next;

    always_ff @(posedge clk or negedge n_rst) begin
        if (!n_rst) begin
            pwm_a <= {SIZE{1'b0}};
            pwm_b <= {SIZE{1'b0}};
        end else if (en) begin
            pwm_a <= pwm_a_next;
            pwm_b <= pwm_b_next;
        end
    end

    always_comb begin
        pwm_a_next = pwm_a;
        pwm_b_next = pwm_b;
        if (en) begin
            if (!inv_a) begin
                pwm_a_next = {cc_a[SIZE-1:0]};
            end if(!inv_b) begin
                pwm_b_next = {cc_b[SIZE-1:0]};
            end else begin
                pwm_a_next = {top[SIZE-1:0]};
                pwm_b_next = {cc_b[SIZE-1:0]};
            end
        end
    end

endmodule

