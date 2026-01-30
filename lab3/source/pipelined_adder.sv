`timescale 1ns / 10ps

module pipelined_adder (

);

  adder_nbit #() stage1 (.a(), .b(), .carry_in(), .sum(), .carry_out());
  adder_nbit #() stage2 (.a(), .b(), .carry_in(), .sum(), .carry_out());
  adder_nbit #() stage3 (.a(), .b(), .carry_in(), .sum(), .carry_out());
  adder_nbit #() stage4 (.a(), .b(), .carry_in(), .sum(), .carry_out());

endmodule

