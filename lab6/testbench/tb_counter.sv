`timescale 1ns / 10ps
/* verilator coverage_off */

module tb_counter ();

    localparam CLK_PERIOD = 10ns;

    logic clk, n_rst;
    logic cnt_up;
    logic clear;
    logic one_k_samples;

    counter dut (.*);

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
        cnt_up = 0;
        clear = 0;
        reset_dut();

        cnt_up = 1;
        repeat (1000) @(negedge clk);
        clear = 1;
        repeat (5) @(negedge clk);

        $finish;
    end
endmodule

/* verilator coverage_on */



