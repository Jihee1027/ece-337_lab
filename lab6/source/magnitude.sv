`timescale 1ns / 10ps

module magnitude (
  input  logic [16:0] in,
  output logic [15:0] out
);
  logic [16:0] in_temp;

  integer i;
  always_comb begin
    in_temp = in;
    if (in_temp[16] == 1'b1) begin
      for (i = 0; i < 17; i = i +1) begin
        if (in_temp[i] == 1'b1) begin
            in_temp[i] = 1'b0;
        end else begin
            in_temp[i] = 1'b1;
        end
      end
      in_temp = in_temp + 1'b1;
    end
    out = in [15:0];
  end
endmodule
