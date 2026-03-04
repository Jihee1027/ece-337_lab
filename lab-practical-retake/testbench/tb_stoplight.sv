`timescale 1ns / 10ps
/* verilator coverage_off */

module tb_stoplight ();

    localparam CLK_PERIOD = 10ns;

    // DUT Ports
    logic clk, n_rst;
    logic carstart, carstop; 
    logic walkstart, walkstop;
    logic rled, yled, gled;

    // DUT Instance
    stoplight DUT (.*);

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
        @(posedge clk);
        @(posedge clk);
    end
    endtask

    task check_outputs;
        input string test_variable;
        input logic expected_data;
        input logic actual_data;
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
        carstart = 0; carstop = 0; walkstart = 0; walkstop = 0;
        reset_dut;

        // TEST 1 Carstop
        n_rst = 0;
        carstart = 0; carstop = 0; walkstart = 0; walkstop = 0;
        @(negedge clk);
        check_outputs ("Test 1: !n_rst (rled)", 1, rled);

        // TEST 2.1 carstart CARSTOP -> GO
        n_rst = 1;
        carstart = 1; carstop = 0; walkstart = 0; walkstop = 0;
        @(negedge clk);
        check_outputs ("Test 2.1: GO (gled)", 1, gled);

        // TEST 2.2 CARSTOP -> WALKSTOP
        n_rst = 0;
        carstart = 0; carstop = 0; walkstart = 0; walkstop = 0;
        reset_dut;
        n_rst = 1;
        carstart = 0; carstop = 0; walkstart = 0; walkstop = 1;
        @(negedge clk);
        @(negedge clk);
        check_outputs ("Test 2.2: WALKSTOP (rled)", 1, rled);

        // TEST 3.1 GO -> CARSLOW
        n_rst = 0;
        carstart = 0; carstop = 0; walkstart = 0; walkstop = 0;
        reset_dut;
        n_rst = 1;
        carstart = 1; carstop = 0; walkstart = 0; walkstop = 0;
        @(negedge clk);
        @(negedge clk);
        carstart = 0; carstop = 1; walkstart = 0; walkstop = 0;
        @(negedge clk);
        check_outputs ("Test 3.1: CARSLOW (yled)", 1, yled);

        //TEST 4: CARSLOW to WALKSTOP
        carstart = 0; carstop = 0; walkstart = 0; walkstop = 1;
        @(negedge clk);
        check_outputs ("Test 4: WALKSTOP (rled)", 1, rled);

        // TEST 5: -> GO -> WALKSLOW
        walkstart = 1;
        @(negedge clk);
        walkstop = 1;
        @(negedge clk);
        check_outputs ("Test 5: WALKSLOW (yled)", 1, yled);

        $finish;
    end
endmodule

/* verilator coverage_on */

