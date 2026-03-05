`timescale 1ns / 10ps
/* verilator coverage_off */

module tb_fir_filter ();

    localparam CLK_PERIOD = 10ns;
    

    // localparam coeff = 16'h8000; // 1.0
    // localparam coeff = 16'hC000; // 1.5
    // localparam coeff = 16'h4000; // 0.5
    // localparam coeff = 16'h2000; // 0.25
    // localparam coeff = 16'h1000; // 0.125

    logic clk, n_rst;
    logic [15:0] sample_data;
    logic [15:0] fir_coefficient;
    logic load_coeff;
    logic data_ready;
    logic one_k_samples;
    logic modwait;
    logic [15:0] fir_out;
    logic err;

    fir_filter dut (.*);

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

    task load_one_coeff(input logic [15:0] c);
    begin
        @(negedge clk);
        wait (modwait == 0);
        fir_coefficient = c;
        load_coeff = 1;  
        @(negedge clk);
        load_coeff = 0;
        @(negedge modwait);
        @(negedge clk);
    end
    endtask

    task send_sample(input logic [15:0] s);
    begin
        wait (modwait == 0);
        @(negedge clk);
        sample_data = s;
        data_ready = 1;
        @(negedge clk);
        @(negedge clk);  
        data_ready = 0;
        wait (modwait == 0);
    end
    endtask

    task send_sample_err(input logic [15:0] s);
    begin
        wait (modwait == 0);
        @(negedge clk);
        sample_data = s;
        data_ready = 1;
        @(negedge clk);  
        data_ready = 0;
        wait (modwait == 0);
    end
    endtask


    initial begin
        n_rst=1; sample_data=0; fir_coefficient=0; load_coeff=0; data_ready=0;
        reset_dut();

        // Test 1: 8000
        load_one_coeff(16'h8000); // F0
        load_one_coeff(16'h0000); // F1
        load_one_coeff(16'h0000); // F2
        load_one_coeff(16'h0000); // F3
        repeat (7) @(negedge clk);
        send_sample(16'h4000);

        wait (modwait == 0);
        repeat (15) @(negedge clk);
        $display("fir_out=%h err=%b", fir_out, err);


        // // Test 2: 8000
        // n_rst=1; sample_data=0; fir_coefficient=0; load_coeff=0; data_ready=0;
        // reset_dut();
        // load_one_coeff(16'h8000); // F0
        // load_one_coeff(16'h8000); // F1
        // load_one_coeff(16'h8000); // F2
        // load_one_coeff(16'h8000); // F3
        // repeat (7) @(negedge clk);
        // send_sample(16'h8000);

        // wait (modwait == 0);
        // repeat (5) @(negedge clk);
        // $display("fir_out=%h err=%b", fir_out, err);

        // // Test 3: 0
        // n_rst=1; sample_data=0; fir_coefficient=0; load_coeff=0; data_ready=0;
        // reset_dut();
        // load_one_coeff(16'h8000); // F0
        // load_one_coeff(16'h8000); // F1
        // load_one_coeff(16'h8000); // F2
        // load_one_coeff(16'h8000); // F3
        // repeat (7) @(negedge clk);
        // send_sample(16'h8000);
        // repeat (10) @(negedge clk);
        // send_sample(16'h8000);

        // wait (modwait == 0);
        // repeat (5) @(negedge clk);
        // $display("fir_out=%h err=%b", fir_out, err);

        // // Test 4: 8000
        // n_rst=1; sample_data=0; fir_coefficient=0; load_coeff=0; data_ready=0;
        // reset_dut();
        // load_one_coeff(16'h8000); // F0
        // load_one_coeff(16'h8000); // F1
        // load_one_coeff(16'h8000); // F2
        // load_one_coeff(16'h8000); // F3
        // repeat (7) @(negedge clk);
        // send_sample(16'h8000);
        // repeat (10) @(negedge clk);
        // send_sample(16'h8000);
        // repeat (10) @(negedge clk);
        // send_sample(16'h8000);

        // wait (modwait == 0);
        // repeat (5) @(negedge clk);
        // $display("fir_out=%h err=%b", fir_out, err);

        // // Test 5: 0
        // n_rst=1; sample_data=0; fir_coefficient=0; load_coeff=0; data_ready=0;
        // reset_dut();
        // load_one_coeff(16'h8000); // F0
        // load_one_coeff(16'h8000); // F1
        // load_one_coeff(16'h8000); // F2
        // load_one_coeff(16'h8000); // F3
        // repeat (7) @(negedge clk);
        // send_sample(16'h8000);
        // repeat (10) @(negedge clk);
        // send_sample(16'h8000);
        // repeat (10) @(negedge clk);
        // send_sample(16'h8000);
        // repeat (10) @(negedge clk);
        // send_sample(16'h8000);

        // wait (modwait == 0);
        // repeat (5) @(negedge clk);
        // $display("fir_out=%h err=%b", fir_out, err);

        // // Test6: one k samples
        // n_rst=1; sample_data=0; fir_coefficient=0; load_coeff=0; data_ready=0;
        // reset_dut();
        // repeat (1001) begin
        //     repeat (10) @(negedge clk); send_sample(16'h8000);
        // end

        // Test7: err (dr)
        // n_rst=1; sample_data=0; fir_coefficient=0; load_coeff=0; data_ready=0;
        // reset_dut();
        // load_one_coeff(16'h8000); // F0
        // load_one_coeff(16'h8000); // F1
        // load_one_coeff(16'h8000); // F2
        // load_one_coeff(16'h8000); // F3
        // repeat (7) @(negedge clk);
        // send_sample_err(16'h8000);

        // wait (modwait == 0);
        // repeat (5) @(negedge clk);
        // $display("fir_out=%h err=%b", fir_out, err);

        // // Test8: err (overflow)
        // n_rst=1; sample_data=0; fir_coefficient=0; load_coeff=0; data_ready=0;
        // reset_dut();
        // load_one_coeff(16'b1); // F0
        // load_one_coeff(16'b1); // F1
        // load_one_coeff(16'b1); // F2
        // load_one_coeff(16'b1); // F3
        // repeat (7) @(negedge clk);
        // send_sample(16'b1);
        // repeat (10) @(negedge clk);
        // send_sample(16'b1);
        // repeat (10) @(negedge clk);
        // send_sample(16'b1);
        // repeat (10) @(negedge clk);
        // send_sample(16'b1);

        // wait (modwait == 0);
        // repeat (5) @(negedge clk);
        // $display("fir_out=%h err=%b", fir_out, err);
        $finish;
    end
endmodule

/* verilator coverage_on */

