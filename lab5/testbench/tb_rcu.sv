`timescale 1ns / 10ps
/* verilator coverage_off */

module tb_rcu ();

    localparam CLK_PERIOD = 10ns;

    logic clk, n_rst;
    logic new_packet_detected;
    logic packet_done;
    logic framing_error;
    logic sbc_clear;
    logic sbc_enable;
    logic load_buffer;
    logic enable_timer;

    // DUT Installation
    rcu DUT (.*);
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
        input logic expected_data, expected_data2, expected_data3, expected_data4;
        input logic actual_data, actual_data2, actual_data3, actual_data4;
    begin
        if (expected_data == actual_data & expected_data2 == actual_data2 & expected_data3 == actual_data3 & expected_data4 == actual_data4) begin: match_outputs
            $display("\x1B[32mPassed. Expected data: %b, %b, %b, %b, Actual data: %d, %d, %d, %d.\x1B[32m",
                    expected_data, expected_data2, expected_data3, expected_data4, actual_data, actual_data2, actual_data3, actual_data4);
        end else begin: different_outputs
            $display("\x1B[31mFailed. Expected data: %b, %b, %b, %b, Actual data: %d, %d, %d, %d.\x1B[32m",
                    expected_data, expected_data2, expected_data3, expected_data4, actual_data, actual_data2, actual_data3, actual_data4);
        end
    end
    endtask


    initial begin
        n_rst = 1;
        new_packet_detected = 0;
        reset_dut();
        @(negedge clk);

        // Test1: IDLE
        check_outputs(0, 0, 0, 0, sbc_clear, sbc_enable, load_buffer, enable_timer);
        
        // Test 2: sbc_clear
        new_packet_detected = 1;
        #(1);
        check_outputs(1, 0, 0, 0, sbc_clear, sbc_enable, load_buffer, enable_timer);

        // Test 3: RECEIVE
        @(negedge clk);
        check_outputs(0, 0, 0, 1, sbc_clear, sbc_enable, load_buffer, enable_timer);

        // Test 4: CHECK_STOP
        packet_done = 1;
        @(negedge clk);
        check_outputs(0, 1, 0, 0, sbc_clear, sbc_enable, load_buffer, enable_timer);

        // Test 5.1 : Framing_Error = 1 -> IDLE
        new_packet_detected = 0;
        framing_error = 1;
        @(negedge clk);
        check_outputs(0, 0, 0, 0, sbc_clear, sbc_enable, load_buffer, enable_timer);

        // Test 5.2: Framing_Error = 0 -> Load
        reset_dut();
        new_packet_detected = 1;
        framing_error = 0;
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        check_outputs(0, 0, 1, 0, sbc_clear, sbc_enable, load_buffer, enable_timer);

        // Test 6: Load -> IDLE
        new_packet_detected = 0;
        @(negedge clk);
        check_outputs(0, 0, 0, 0, sbc_clear, sbc_enable, load_buffer, enable_timer);

        // Test 7: Recieve -> IDLE;
        new_packet_detected = 0;
        @(negedge clk);
        n_rst = 0;
        @(negedge clk);
        check_outputs(0, 0, 0, 0, sbc_clear, sbc_enable, load_buffer, enable_timer);

        $finish;
    end
endmodule

/* verilator coverage_on */


