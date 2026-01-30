`timescale 1ns / 10ps

module stp_4bit (
    input logic clk,
    input logic n_rst,
    input logic shift_enable,
    input logic serial_in,
    output logic [3:0] parallel_out
);

    always_ff @(posedge clk or negedge n_rst) begin
        if (!n_rst)
            parallel_out <= 4'b0000;
        else if (shift_enable)
            parallel_out <= {serial_in, parallel_out[3:1]};
    end


endmodule

