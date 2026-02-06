`timescale 1ns / 10ps
/* verilator coverage_off */

module tb_fsm ();

    localparam CLK_PERIOD = 10ns;

    logic clk, n_rst;

    // Mimic the Grading TB's Constants Lookup Table
    logic const_select;
    logic [7:0] data_const;
    assign data_const = const_select ? 8'hBB : 8'hAA;

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

        reset_dut;

        $finish;
    end
endmodule

/* verilator coverage_on */

