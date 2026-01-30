// 337 TA Provided Lab 4 Starter Testbench

// 0.5um D-FlipFlop Timing Data Estimates:
// Data Propagation delay (clk->Q): 670ps
// Setup time for data relative to clock: 190ps
// Hold time for data relative to clock: 10ps

`timescale 1ns / 10ps

module tb_edge_det();

  parameter edge_type = 0;

  localparam COLNRM = "\x1B[0m";
  localparam COLRED = "\x1B[31m";
  localparam COLGRN = "\x1B[32m";
  localparam COLCYA = "\x1B[36m";

  // Define local parameters used by the test bench
  localparam  CLK_PERIOD    = 2.5;
  localparam  FF_SETUP_TIME = 0.190;
  localparam  FF_HOLD_TIME  = 0.100;
  // Propagation Delay clk->q is 0.57ns or 0.65ns per Tech Lib, l->h, h->l
  localparam  CHECK_DELAY   = (CLK_PERIOD - FF_SETUP_TIME); // Check right before the setup time starts
  
  string test_name;
  logic check_pulse;

  // Declare DUT portmap signals
  logic clk, n_rst;
  logic async_in, sync_out, edge_flag;

  /* verilator lint_off GENUNNAMED */
  generate
    if(edge_type == 1)      edge_rise DUT (.clk(clk), .n_rst(n_rst), .async_in(async_in), .sync_out(sync_out), .edge_flag(edge_flag));
    else if(edge_type == 2) edge_dual DUT (.clk(clk), .n_rst(n_rst), .async_in(async_in), .sync_out(sync_out), .edge_flag(edge_flag));
    else initial begin
      $display("ERROR: Incorrect sync type specified: %d", edge_type);
      $stop;
    end
  endgenerate
  /* verilator lint_on GENUNNAMED */

  // Clock generation block
  always
  begin
    // Start with clock low to avoid false rising edge events at t=0
    clk = 1'b0;
    // Wait half of the clock period before toggling clock value (maintain 50% duty cycle)
    #(CLK_PERIOD/2.0);
    clk = 1'b1;
    // Wait half of the clock period before toggling clock value via rerunning the block (maintain 50% duty cycle)
    #(CLK_PERIOD/2.0);
  end
  
  // Task for standard DUT reset procedure
  task reset_dut;
  begin
    // Activate the reset
    n_rst = 1'b0;

    // Maintain the reset for more than one cycle
    @(posedge clk);
    @(posedge clk);

    // Wait until safely away from rising edge of the clock before releasing
    @(negedge clk);
    n_rst = 1'b1;

    // Leave out of reset for a couple cycles before allowing other stimulus
    // Wait for negative clock edges, 
    // since inputs to DUT should normally be applied away from rising clock edges
    @(negedge clk);
    @(negedge clk);
  end
  endtask

  task reset_inputs;
    async_in = 0;
  endtask

  task init;
    reset_inputs();
    n_rst = 1'b1;
    test_name = "";
    check_pulse = 0;
    #(0.1); // Wait for first Test Case
  endtask
  
  // Test bench main process
  integer i;

  initial
  begin
    init();
    reset_dut();

    // Test1 : No Edges
    test_name = "No Input Edges";
    async_in = 0;
    repeat(4) @(negedge clk);

    #(CHECK_DELAY);
    if (edge_flag !==0)
      $display("%sFAIL%s: edge_flag asserted during no inputs", COLRED, COLNRM);
    
    // Test2: Rsing Edge
    test_name = "Rising Edge Detect";
    @(negedge clk);
    async_in = 1;
    repeat(2) @(posedge clk);

    #(CHECK_DELAY);
    if (edge_type == 1 || edge_type ==  2) begin
      if (edge_flag != 1)
        $display("%sFAIL%s: rising edge not detected", COLRED, COLNRM);
    end

    // Next cycle edge_flag must drop
    @(posedge clk);
    #(CHECK_DELAY);
    if (edge_flag != 0)
      $display("%sFAIL%s: edge_flag longer than 1 cycle", COLRED, COLNRM);
    
    // Test3: Falling edge
    test_name = "Falling Edge Detect";
    @(negedge clk);
    async_in = 0;
    repeat(2) @(posedge clk);

    #(CHECK_DELAY);
    if (edge_type == 2) begin
      if (edge_flag !== 1)
        $display("%sFAIL%s: falling edge not detected", COLRED, COLNRM);
    end else begin
      if (edge_flag !== 0)
        $display("%sFAIL%s: rising only detected falling edge", COLRED, COLNRM);
    end

    @(posedge clk);
    #(CHECK_DELAY);
    if (edge_flag !== 0)
      $display("%sFAIL%s: edge_flag longer than 1 cycle", COLRED, COLNRM);
    
    // Test 4: Back to Back Edges
    test_name = "Back to Back Edges";
    for (i = 0; i < 3; i++) begin
      @(negedge clk);
      async_in = ~async_in;
      repeat(2) @(posedge clk);
      #(CHECK_DELAY);
      if (edge_flag !== 1)
        $display("%sFAIL%s: missed edge at iteration %0d", COLRED, COLNRM, i);

      @(posedge clk);
      #(CHECK_DELAY);
      if (edge_flag !== 0)
        $display("%sFAIL%s: edge_flag too long", COLRED, COLNRM);
    end

    $display("%sALL tests complted%s", COLGRN, COLNRM);
    $finish;
  end
endmodule
