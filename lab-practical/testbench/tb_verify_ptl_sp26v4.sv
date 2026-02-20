`timescale 1ns / 10ps
/* verilator coverage_off */

module tb_verify_ptl_sp26v4 ();

    localparam CLK_PERIOD = 10ns;

    logic clk, n_rst;
    logic wen;
    logic ren;
    logic [7:0] din;
    logic empty;
    logic close;
    logic full;
    logic [7:0] dout;

    // verify_ptl_sp26v4 dut(
    //     .clk(clk),
    //     .n_rst(n_rst),
    //     .wen(wen),
    //     .ren(ren),
    //     .din(din),
    //     .empty(empty),
    //     .close(close),
    //     .full(full),
    //     .dout(dout)
    // );

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

    verify_ptl_sp26v4 #() DUT (.*);

    initial begin
        n_rst = 0;
        
        @(negedge clk);#1ps; 
     

        //Test 1 reset
        $display("Test 1: Reset empty = %d, close = %d, full = %d, dout = %d", empty, close, full, dout);
        // if (empty !== 0 | close !== 0 | full !== 0 | dout !== '0) begin
        //     $error("Test 1 Failed - empty = %d, close = %d, full = %d, dout = %d", empty, close, full, dout);
        // end
        reset_dut();
        // Test 2
        @(negedge clk);#1ps; 
        wen = 1;
        $display("Test 2: Wire Enable empty = %d, close = %d, full = %d, dout = %d", empty, close, full, dout);

        // Test 3
        @(negedge clk);#1ps; 
        wen = 1;
        ren = 1; 
        $display("Test 3: Wire Enabl and read enable empty = %d, close = %d, full = %d, dout = %d", empty, close, full, dout);
        $finish;
    end
endmodule

/* verilator coverage_on */

