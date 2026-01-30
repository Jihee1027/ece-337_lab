`timescale 1ns / 10ps

module sync #(
    parameter logic RST_VAL = 1'b0
) (
    input logic clk,
    input logic n_rst,
    input logic async_in,
    output logic sync_out
);

    logic stage1;

    always_ff @( posedge clk, negedge n_rst )
    begin : sync_ff
        if(1'b0 == n_rst) begin
            stage1 <= RST_VAL;
            sync_out <= RST_VAL;
        end
        else begin
            stage1 <= async_in;
            sync_out <= stage1;
        end
    end
endmodule

