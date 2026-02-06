`timescale 1ns / 10ps

module adder_128bit (
    input logic [127:0] a,
    input logic [127:0] b,
    output logic [128:0] s
);

    logic carry_out;

    adder_nbit #(
        .N(128)
    ) u_adder_128 (
        .a         (a),
        .b         (b),
        .carry_in  (1'b0),
        .sum       (s[127:0]),
        .carry_out (carry_out)
    );
    
     assign s[128] = carry_out;


endmodule

