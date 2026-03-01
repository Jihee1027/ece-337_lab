module magnitude (
  input  logic signed [16:0] in,
  output logic [15:0] out
);
  logic signed [16:0] abs;
  always_comb begin
    abs = (in < 0) ? -in : in;
    out = abs[15:0];  
  end
endmodule