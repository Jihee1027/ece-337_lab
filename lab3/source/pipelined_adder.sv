`timescale 1ns / 10ps

module pipelined_adder (
  input logic clk,
  input logic n_rst,
  input logic [127:0] a,
  input logic [127:0] b,
  output logic [128:0] s
);
  logic [31:0] s1, s2, s3, s4;
  logic c0, c1, c2, c3, c4;
  logic [31:0] s1_p1, s1_p2, s1_p3, s2_p2, s2_p3, s3_p3;
  logic c1_p, c2_p, c3_p;
  logic [128:0] s_comb;
  assign c0 = 1'b0;


  adder_nbit #(.N(32)) stage1 (.a(a[31:0]), .b(b[31:0]), .carry_in(c0), .sum(s1), .carry_out(c1));
  adder_nbit #(.N(32)) stage2 (.a(a[63:32]), .b(b[63:32]), .carry_in(c1_p), .sum(s2), .carry_out(c2));
  adder_nbit #(.N(32)) stage3 (.a(a[95:64]), .b(b[95:64]), .carry_in(c2_p), .sum(s3), .carry_out(c3));
  adder_nbit #(.N(32)) stage4 (.a(a[127:96]), .b(b[127:96]), .carry_in(c3_p), .sum(s4), .carry_out(c4));

  always_ff @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
        s1_p1 <= '0; s1_p2 <= '0; s1_p3 <= '0; c1_p <= '0;
        s2_p2 <= '0; s2_p3 <= '0; c2_p <= '0;
        s3_p3 <= '0; c3_p <= '0;
    end else begin
        // stage1
        s1_p1 <= s1;
        c1_p <= c1;

        // stage2
        s2_p2 <= s2;
        c2_p <= c2;
        // s1_p2 <= s1_p1;

        // stage3
        s3_p3 <= s3;
        c3_p <= c3;
        s1_p3 <= s1_p1;
        s2_p3 <= s2_p2;

    end
  end

  always_comb begin
    s_comb = {c4, s4, s3_p3, s2_p3, s1_p3};
  end

  always_ff @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
        s <= '0;
    end else begin
        s <= s_comb;
    end
  end

endmodule