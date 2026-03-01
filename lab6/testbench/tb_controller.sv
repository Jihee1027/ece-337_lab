`timescale 1ns / 10ps
/* verilator coverage_off */

module tb_controller ();

    localparam CLK_PERIOD = 10ns;

    logic clk, n_rst;
    logic dr;
    logic lc;
    logic overflow;
    logic cnt_up;
    logic clear;
    logic modwait;
    logic [2:0] op;
    logic [3:0] src1;
    logic [3:0] src2;
    logic [3:0] dest;
    logic err;

    controller DUT (.*);

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

    task check_outputs;
        input string test_variable;
        input logic [7:0] expected_data;
        input logic [7:0] actual_data;
    begin
        if (expected_data == actual_data) begin: match_outputs
            $display("\x1B[32m %s Passed. Expected data: %d, Actual data: %d.\x1B[32m",
                    test_variable, expected_data, actual_data);
        end else begin: different_outputs
            $display("\x1B[31m %s Failed. Expected data: %d, Actual data: %d.\x1B[32m",
                    test_variable, expected_data, actual_data);
        end
    end
    endtask

    initial begin
        n_rst = 1;
        dr = 0;
        lc = 0;
        overflow = 0;
        reset_dut();

        // TEST 1 IDLE
        @(negedge clk);
        check_outputs("Test 1: IDLE modwait", 0, modwait);

        // TEST 2 CHECK_DR
        dr = 1;
        @(negedge clk);
        check_outputs("Test 2: CHECK_DR err", 0, err);
        check_outputs("Test 2: CHECK_DR modwait", 1, modwait);

        // TEST 3 DR_ERR
        dr = 0;
        @(negedge clk);
        check_outputs("Test 3: DR_ERR err", 1, err);
        check_outputs("Test 3: DR_ERR modwait", 0, modwait);

        // TEST 3.1 Still Error
        dr = 1;
        @(negedge clk);
        check_outputs("Test 3.1: CHECK_DR_ERR err", 1, err);
        check_outputs("Test 3.1: CHECK_DR_ERR modwait", 0, modwait);

        // TEST 3.2 Out of Error (SHIFT4)
        dr = 1;
        @(negedge clk);
        check_outputs("Test 3.2: SHIFT4 err", 0, err);
        check_outputs("Test 3.2: SHIFT4 modwait", 1, modwait);
        check_outputs("Test 3.2: SHIFT4 op", 3'd1, op);
        check_outputs("Test 3.2: SHIFT4 src1", 4'd3, src1);
        check_outputs("Test 3.2: SHIFT4 dest", 4'd4, dest);


        // TEST 4 CHECK_DR -> SHIFT4_3
        dr = 0;
        lc = 0;
        overflow = 0;
        reset_dut();
        dr = 1;
        repeat (2) @(negedge clk);
        check_outputs("Test 4: SHIFT4 modwait", 1, modwait);
        check_outputs("Test 4: SHIFT4 err", 0, err);
        check_outputs("Test 4: SHIFT4 op", 3'd1, op);
        check_outputs("Test 4: SHIFT4 src1", 4'd3, src1);
        check_outputs("Test 4: SHIFT4 dest", 4'd4, dest);

        // TEST 5 SHIFT4_3 -> SHIFT3_2
        @(negedge clk);
        check_outputs("Test 5: SHIFT3 modwait", 1, modwait);
        check_outputs("Test 5: SHIFT3 err", 0, err);
        check_outputs("Test 5: SHIFT3 op", 3'd1, op);
        check_outputs("Test 5: SHIFT3 src1", 4'd2, src1);
        check_outputs("Test 5: SHIFT3 dest", 4'd3, dest);

        repeat (15) @(negedge clk);

        lc = 1;
        dr = 0;
        reset_dut();
        @(negedge clk);


        $finish;
    end
endmodule

/* verilator coverage_on */

