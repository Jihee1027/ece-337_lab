`timescale 1ns / 10ps
/* verilator coverage_off */

module tb_fir_filter ();

    localparam CLK_PERIOD = 10ns;

    localparam coeff = 16'h8000; // 1.0
    localparam coeff = 16'hC000; // 1.5
    localparam coeff = 16'h4000; // 0.5
    localparam coeff = 16'h2000; // 0.25
    localparam coeff = 16'h1000; // 0.125

    logic clk, n_rst;
    logic [15:0] sample_data;
    logic [15:0] fir_coefficient;
    logic load_coeff;
    logic data_ready;
    logic one_k_samples;
    logic modwait;
    logic [15:0] fir_out;
    logic err;

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
        reset_dut();


        $finish;
    end
endmodule

/* verilator coverage_on */

