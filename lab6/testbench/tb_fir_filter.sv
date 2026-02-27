`timescale 1ns / 10ps
/* verilator coverage_off */

module tb_fir_filter ();

    localparam CLK_PERIOD = 20ns;

    localparam coeff = 16'h8000; // 1.0
    localparam coeff = 16'hC000; // 1.5
    localparam coeff = 16'h4000; // 0.5
    localparam coeff = 16'h2000; // 0.25
    localparam coeff = 16'h1000; // 0.125

    logic clk, n_rst;

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

        reset_dut();

        $finish;
    end
endmodule

/* verilator coverage_on */

