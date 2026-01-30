`timescale 1ns / 10ps
/* verilator coverage_off */

module tb_stp_4bit ();

    localparam CLK_PERIOD = 2.5ns;

    logic clk, n_rst;
    logic serial_in;
    logic shift_enable;

    logic [3:0] parallel_out;

    stp_4bit dut (
    .clk(clk),
    .n_rst(n_rst),
    .shift_enable(shift_enable),
    .serial_in(serial_in),
    .parallel_out(parallel_out)
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
        n_rst = 1;
        shift_enable = 0;
        serial_in = 0;

        // Test 1: Power on reset
        reset_dut;
        $display("Test 1: Reset - parallel_out = %b (Expected: 0000)", parallel_out);

        if (parallel_out !== 4'b0000) begin
            $error("RESET FAILED: parallel_out = %b", parallel_out);
        end

        // Test 2: Fill SR with 0
        @(negedge clk);
        shift_enable = 1;
        repeat (4) begin
            serial_in = 0;
            @(negedge clk);
        end
        $display("Test 2: Fill 0000 - parallel_out = %b (Expected: 0000)", parallel_out);

        if (parallel_out !== 4'b0000) begin
            $error("SHIFT 0000 FAILED: parallel_out = %b", parallel_out);
        end

        // Test 3: Discontinous shifting
        serial_in = 1;
        @(negedge clk);     //shift in 1

        shift_enable = 0;
        serial_in = 0;
        @(negedge clk);     //should not shift
        $display("Test 3: Discontinuous - parallel_out = %b (Expected: 1000)", parallel_out);

        if (parallel_out !== 4'b1000) begin
            $error("DISABLE FAILED: parallel_out = %b", parallel_out);
        end

        shift_enable = 1;
        serial_in = 0; @(negedge clk); // Shift in 0 (Result: 0100)
        serial_in = 1; @(negedge clk); // Shift in 1 (Result: 1010)
        serial_in = 0; @(negedge clk); // Shift in 0 (Result: 0101)
        serial_in = 1; @(negedge clk); // Shift in 1 (Result: 1010)
        $display("Test 4: Load 1010 - parallel_out = %b (Expected: 1010)", parallel_out);

        // End
        $display("All tests completed");
        $finish;
    end
endmodule

/* verilator coverage_on */

