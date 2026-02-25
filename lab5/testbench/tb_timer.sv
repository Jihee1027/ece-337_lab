`timescale 1ns / 10ps
/* verilator coverage_off */

module tb_timer ();

    localparam CLK_PERIOD = 10ns;

    logic clk, n_rst;
    logic enable_timer;
    logic shift_strobe;
    logic packet_done;
    logic unsigned [7:0] i;
    string test;

    // DUT installation
    timer dut (
        .clk(clk),
        .n_rst(n_rst),
        .enable_timer(enable_timer),
        .shift_strobe(shift_strobe),
        .packet_done(packet_done)
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

    task check_outputs;
        input logic expected_data, actual_data;
    begin
        if (expected_data == actual_data) begin: match_outputs
            $display("\x1B[32mPassed. Expected data: %b, Actual data: %d .\x1B[32m",
                    expected_data, actual_data);
        end else begin: different_outputs
            $display("\x1B[31mFailed. Expected data: %b, Actual data: %d .\x1B[32m",
                    expected_data, actual_data);
        end
    end
    endtask

    initial begin
        n_rst = 1;
        enable_timer = 0;
        reset_dut();
        // Test 1: Power Reset
        check_outputs(0, shift_strobe);
        check_outputs(0, packet_done);
        // Test 2: Check shift_strobe
        enable_timer = 1;

        
    
        for (i = 0; i < 100; i ++) begin : gen_for_loop
            @(negedge clk);
        end
        
        check_outputs(1, shift_strobe);
        check_outputs(0, packet_done);
        // Test 3: Check packet_done
        check_outputs(0,shift_strobe);
        check_outputs(1, packet_done);
        $finish;
    end
endmodule

/* verilator coverage_on */

