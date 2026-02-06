`timescale 1ns / 10ps

module stp_4bit (
    input logic clk,
    input logic n_rst,
    input logic shift_enable,
    input logic serial_in,
    output logic [3:0] parallel_out
);


    logic [3:0] next_parallel_out;

    always_ff @(posedge clk or negedge n_rst) begin
        if (!n_rst) begin
            parallel_out <= 4'b1111;
        end else if (shift_enable) begin
            parallel_out <= next_parallel_out;
        end
    end

    always_comb begin
        if(shift_enable) begin
            next_parallel_out = {serial_in, (parallel_out [3:1])};
        end else begin
            next_parallel_out = parallel_out;
        end
    end


endmodule

