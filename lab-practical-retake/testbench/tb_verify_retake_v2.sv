`timescale 1ns / 10ps
/* verilator coverage_off */

module tb_verify_retake_v2 ();

    localparam CLK_PERIOD = 10ns;

    logic clk, n_rst;
    logic [3:0] inc;
    logic [11:0] acc;
    logic en;
    logic clr;
    logic min;
    logic zro;
    logic max;

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
        input logic [11:0]expected_data;
        input logic [11:0]actual_data;
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

    verify_retake_v2 #() DUT (.*);

    initial begin
        n_rst = 0;
        inc = 4'b0; en = 0; clr = 0; 
        reset_dut;
        n_rst = 1;
        inc = 4'b1; en = 1; clr = 0; 
        @(negedge clk);
        // Test 1
        check_outputs ("Test 1:", 12'b1, acc);

        // Test 1.1: active low reset
        n_rst = 0;
        @(negedge clk);
        inc = 1000; en = 1; clr = 0; 
        check_outputs ("Test 1.1:", 12'b1, acc);

        // Test 2: clear = 1
        n_rst = 1;
        en = 0;
        clr = 1; 
        @(negedge clk); 
        check_outputs ("Test 2:", 12'b0, acc);

        reset_dut;
        en = 1;
        clr = 0;
        check_outputs ("Test reset:", 12'b0, acc);

        // Test 4: increasing / saturating
        inc = 1111;
        repeat (3000) @(negedge clk);
        check_outputs ("Test inc:", 12'b0, acc);

        reset_dut;
        // Test 5: minimum
        inc = 1000;
        repeat (3000) @(negedge clk);
        check_outputs ("Test dec:", 12'b0, acc);

        // Test 6: zro
        clr = 1;
        reset_dut;
        @(negedge clk);
        check_outputs ("Test zro:", 12'b0, acc);
        inc = 1110;
        @(negedge clk);
        check_outputs ("Test zro:", 12'b0, acc);

        inc = 0001;
        @(negedge clk);

        $finish;
    end
endmodule

/* verilator coverage_on */

