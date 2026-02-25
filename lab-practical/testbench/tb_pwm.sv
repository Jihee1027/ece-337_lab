`timescale 1ns / 10ps
/* verilator coverage_off */

module tb_pwm ();

    localparam CLK_PERIOD = 10ns;

    logic clk, n_rst;
    logic en;
    logic inv_a;
    logic inv_b;
    logic [7:0] top;
    logic [7:0] cc_a;
    logic [7:0] cc_b;
    logic [7:0] pwm_a;
    logic [7:0] pwm_b;



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

    pwm #() DUT (.*);

    initial begin
        n_rst = 1;
        reset_dut;
        // Test 1 reset
        $display ("Test 1: Reset pwm_a = %b, pwm_b = %b", pwm_a, pwm_b);

        $finish;
    end
endmodule

/* verilator coverage_on */

