`timescale 1ns / 10ps

module magnitude (
  input  logic [16:0] in,
  output logic [15:0] out
);
  logic [16:0] in_temp;

  always_comb begin
    if (in[16] == 1'b1) begin
      in_temp = (~in) + 1'b1;
    end else begin
      in_temp = in;
    end
    out = in_temp[15:0];
  end
endmodule
