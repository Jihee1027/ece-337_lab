`timescale 1ns / 10ps
/* verilator coverage_off */

module tb_pts_4bit ();

    localparam CLK_PERIOD = 2.5ns;

    logic clk, n_rst;
    logic shift_enable;
    logic load_enable;
    logic [3:0] parallel_in;
    logic serial_out;

    // DUT instantiation
    pts_4bit dut (
        .clk(clk),
        .n_rst(n_rst),
        .shift_enable(shift_enable),
        .load_enable(load_enable),
        .parallel_in(parallel_in),
        .serial_out(serial_out)
    );
    // clockgen
    always begin
        clk = 0;
        #(CLK_PERIOD / 2.0);
        clk = 1;
        #(CLK_PERIOD / 2.0);
    end

    task reset_dut;
    begin
        n_rst = 0;
        @(posedge clk);
        @(posedge clk);
        @(negedge clk);
        n_rst = 1;
        @(negedge clk);
        @(negedge clk);
    end
    endtask

    initial begin
        clk = 0;
        n_rst = 1;
        shift_enable = 0;
        load_enable  = 0;
        parallel_in  = 4'b0000;
        // Test 1: Power on Reset
        reset_dut;
        $display("Test 1: Reset - parallel_out = %b (Expected: 1111)", dut.CORE.parallel_out);

        if (dut.CORE.parallel_out !== 4'b1111)
            $error("RESET FAILED");
        
        // Test 2: Fill SR with 0000
        @(negedge clk);
        load_enable = 1;
        parallel_in = 4'b0000;
        @(negedge clk);
        load_enable = 0;

        $display("Test 2: Load 0000 - parallel_out = %b (Expected: 0000)", dut.CORE.parallel_out);

        if (dut.CORE.parallel_out !== 4'b0000)
            $error("LOAD 0000 FAILED");
        
        // Test 3: Load Nonzero Value (1010)
        @(negedge clk);
        load_enable = 1;
        parallel_in = 4'b1010;
        @(negedge clk);
        load_enable = 0;

        $display("Test 3: Load 1010 - parallel_out = %b (Expected: 1010)", dut.CORE.parallel_out);

        if (dut.CORE.parallel_out !== 4'b1010)
            $error("LOAD 1010 FAILED");

        // Test 4: Discontinuous shifting
        @(negedge clk);
        shift_enable = 1; 
        @(negedge clk);

        shift_enable = 0;   
        @(negedge clk);

        $display("Test 4: Discontinuous - parallel_out = %b", dut.CORE.parallel_out);

        // Test 5: Load while Shifting
        @(negedge clk);
        shift_enable = 1;
        load_enable  = 1;
        parallel_in  = 4'b0101;
        @(negedge clk);

        shift_enable = 0;
        load_enable  = 0;

        $display("Test 5: Load + Shift - parallel_out = %b (Expected: 0101)", dut.CORE.parallel_out);

        if (dut.CORE.parallel_out !== 4'b0101)
            $error("LOAD PRIORITY FAILED");
        
        $display("All PTS tests completed successfully");
        $finish;
    end
endmodule

/* verilator coverage_on */

