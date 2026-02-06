`timescale 1ns / 10ps

module flex_sr #(
    parameter SIZE = 8,
    parameter MSB_FIRST = 0
) (
    input logic clk,
    input logic n_rst,
    input logic shift_enable,
    input logic load_enable,
    input logic serial_in,
    input logic [SIZE-1:0] parallel_in,
    output logic serial_out,
    output logic [SIZE-1:0] parallel_out
);

    logic [SIZE-1:0] next_parallel_out;

    always_ff @(posedge clk or negedge n_rst) begin
        if (!n_rst) begin
            parallel_out <= {SIZE{1'b1}};
        end else if (load_enable) begin
            parallel_out <= parallel_in;
        end else if (shift_enable) begin
            parallel_out <= next_parallel_out;
        end
    end

    always_comb begin
         next_parallel_out = parallel_out;
        if (shift_enable) begin
            if (MSB_FIRST) begin
                next_parallel_out = {parallel_out[SIZE-2:0], serial_in};
            end else begin
                next_parallel_out = {serial_in, parallel_out[SIZE-1:1]};
            end
        end
    end

    always_comb begin
        if (MSB_FIRST) begin
            serial_out = parallel_out[SIZE-2];
        end else begin
            serial_out = parallel_out[0];
        end
    end
    

endmodule

