`timescale 1ns / 10ps

module adder_nbit #(
    parameter N = 8
)(
    input logic [N-1:0] a,
    input logic [N-1:0] b,
    input logic carry_in,
    output logic [N-1:0] sum,
    output logic carry_out
);
    logic [N:0] cn;

    assign cn[0] = carry_in;
    assign carry_out = cn[N];
    generate
        genvar i; 
        for (i = 0; i < N; i ++) begin : gen_for_loop
            full_adder FA (.a(a[i]), .b(b[i]), .carry_in(cn[i]), .sum(sum[i]), .carry_out(cn[i+1]));
        end
    endgenerate

endmodule

