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

    initial begin
        n_rst = 1;

        reset_dut;

        $finish;
    end
endmodule

/* verilator coverage_on */

