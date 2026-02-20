`timescale 1ns/10ps

module tb_flex_counter_tv;

  localparam CLK_PERIOD = 10ns;
  localparam SIZE = 4;

  logic clk, n_rst;
  logic clear, count_enable;
  logic [SIZE-1:0] rollover_value;
  logic [SIZE-1:0] count_out;
  logic rollover_flag;

  // DUT
  flex_counter #(.SIZE(SIZE)) dut (
    .clk(clk),
    .n_rst(n_rst),
    .clear(clear),
    .count_enable(count_enable),
    .rollover_val(rollover_value),
    .count_out(count_out),
    .rollover_flag(rollover_flag)
  );

  // clock
  always begin
    clk = 0; #(CLK_PERIOD/2);
    clk = 1; #(CLK_PERIOD/2);
  end

  // -------------------------------
  // Test Vector Definition
  // -------------------------------
  typedef struct {
    logic clear;
    logic count_enable;
    logic [SIZE-1:0] rollover_value;
    int wait_cycles;
    logic [SIZE-1:0] exp_count;
    logic exp_flag;
  } tv_t;

  tv_t tv[6];

  task reset_dut;
  begin
    n_rst = 0;
    repeat(2) @(posedge clk);
    n_rst = 1;
    @(posedge clk);
  end
  endtask

  initial begin
    // Initialize
    clear = 0;
    count_enable = 0;
    rollover_value = 7;
    reset_dut;

    // -------------------------------
    // Define Test Vectors
    // -------------------------------

    // TV0: Reset state
    tv[0] = '{0,0,7, 0, 0,0};

    // TV1: Count 3 cycles
    tv[1] = '{0,1,7, 3, 3,0};

    // TV2: Reach rollover (7)
    tv[2] = '{0,1,7, 4, 7,1};

    // TV3: After rollover
    tv[3] = '{0,1,7, 1, 1,0};

    // TV4: Hold when disabled
    tv[4] = '{0,0,7, 2, 1,0};

    // TV5: Clear priority
    tv[5] = '{1,1,7, 1, 0,0};

    // -------------------------------
    // Execute Test Vectors
    // -------------------------------

    for(int i=0;i<6;i++) begin

      clear = tv[i].clear;
      count_enable = tv[i].count_enable;
      rollover_value = tv[i].rollover_value;

      repeat(tv[i].wait_cycles) @(posedge clk);
      #1ps;

      if(count_out !== tv[i].exp_count)
        $error("TV %0d COUNT FAIL: got=%0d exp=%0d",
               i, count_out, tv[i].exp_count);

      if(rollover_flag !== tv[i].exp_flag)
        $error("TV %0d FLAG FAIL: got=%b exp=%b",
               i, rollover_flag, tv[i].exp_flag);

    end

    $display("All TV tests completed.");
    $finish;
  end

endmodule