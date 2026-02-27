`timescale 1ns / 10ps
/* verilator coverage_off */

module tb_rcv_block ();

    localparam CLK_PERIOD = 2.5ns;

    logic clk, n_rst;
    logic serial_in;
    logic data_read;
    logic [7:0] rx_data;
    logic data_ready;
    logic overrun_error;
    logic framing_error;

    // DUT Installation
    rcv_block DUT (.*);

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

    // logic serial_in;
    logic stop_bit; // or localparam stop_bit = 1;

    task send_packet;
      input [7:0] data;
      input stop_bit;
      input time data_period;

      integer i;
      begin
        // First synchronize to away from clock's rising edge
        @(negedge clk)

        // Send start bit
        serial_in = 1'b0;
        #data_period;

        // Send data bits
        for(i = 0; i < 8; i = i + 1)
        begin
          serial_in = data[i];
          #data_period;
        end

        // Send stop bit
        serial_in = stop_bit;
        #data_period;
      end
    endtask

    task check_outputs;
        input logic [7:0] expected_data, expected_data2, expected_data3, expected_data4;
        input logic [7:0] actual_data, actual_data2, actual_data3, actual_data4;
    begin
        if (expected_data == actual_data & expected_data2 == actual_data2 & expected_data3 == actual_data3 & expected_data4 == actual_data4) begin: match_outputs
            $display("\x1B[32mPassed. Expected data: %b, %b, %b, %b, Actual data: %b, %b, %b, %b.\x1B[32m",
                    expected_data, expected_data2, expected_data3, expected_data4, actual_data, actual_data2, actual_data3, actual_data4);
        end else begin: different_outputs
            $display("\x1B[31mFailed. Expected data: %b, %b, %b, %b, Actual data: %b, %b, %b, %b.\x1B[32m",
                    expected_data, expected_data2, expected_data3, expected_data4, actual_data, actual_data2, actual_data3, actual_data4);
        end
    end
    endtask

    initial begin
        data_read = 0;
        n_rst = 0;
        serial_in = 1'b1;
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        reset_dut();
        n_rst = 1;

        // First data
        data_read = 1'b0;
        send_packet(8'b0, 1'b1, 25ns);
        wait (data_ready === 1'b1);
        @(negedge clk);
        check_outputs(8'b0, 8'd1, 8'd0, 8'd0, rx_data, data_ready, overrun_error, framing_error);
        @(negedge clk);
        data_read = 1'b1;
        @(negedge clk);
        data_read = 1'b0;
        serial_in = 1'b1;
        #(2*25ns);

        // Second data
        send_packet(8'b10101010, 1'b1, 24.04ns);
        wait (data_ready === 1'b1);
        @(negedge clk);
        check_outputs(8'b10101010, 8'd1, 8'd0, 8'd0, rx_data, data_ready, overrun_error, framing_error);
        @(negedge clk);
        data_read = 1'b1;
        @(negedge clk);
        data_read = 1'b0;
        serial_in = 1'b1;
        #(2*24.04ns);

        // Third data
        send_packet(8'b11110000, 1'b1, 26.04ns);
        wait (data_ready === 1'b1);
        @(negedge clk);
        check_outputs(8'b11110000, 8'd1, 8'd0, 8'd0, rx_data, data_ready, overrun_error, framing_error);
        @(negedge clk);
        data_read = 1'b1;
        @(negedge clk);
        data_read = 1'b0;
        serial_in = 1'b1;
        #(2*26.04ns);

        // Forth data
        send_packet(8'b00110011, 1'b1, 26.04ns);
        wait (data_ready === 1'b1);
        @(negedge clk);
        check_outputs(8'b00110011, 8'd1, 8'd0, 8'd0, rx_data, data_ready, overrun_error, framing_error);
        @(negedge clk);
        data_read = 1'b1;
        @(negedge clk);
        data_read = 1'b0;
        serial_in = 1'b1;
        #(2*26.04ns);

        // Fifth data
        send_packet(8'b00001111, 1'b1, 24.04ns);
        wait (data_ready === 1'b1);
        @(negedge clk);
        check_outputs(8'b00001111, 8'd1, 8'd0, 8'd0, rx_data, data_ready, overrun_error, framing_error);
        @(negedge clk);
        data_read = 1'b1;
        @(negedge clk);
        data_read = 1'b0;
        serial_in = 1'b1;
        #(2*24.04ns);

        // Framing Error
        send_packet(8'b00001111, 1'b0, 24.04ns);
        wait (framing_error === 1'b1);
        @(negedge clk);
        check_outputs(8'b00001111, 8'd0, 8'd0, 8'd1, rx_data, data_ready, overrun_error, framing_error);
        @(negedge clk);
        data_read = 1'b1;
        @(negedge clk);
        data_read = 1'b0;
        serial_in = 1'b1;
        #(2*24.04ns);

        // Overrun Error
        send_packet(8'b00001111, 1'b1, 25ns);
        @(negedge clk);
        send_packet(8'b00001111, 1'b1, 25ns);
        wait (overrun_error === 1'b1);
        @(negedge clk);
        check_outputs(8'b00001111, 8'd1, 8'd1, 8'd0, rx_data, data_ready, overrun_error, framing_error);
        @(negedge clk);
        data_read = 1'b1;
        @(negedge clk);
        data_read = 1'b0;
        serial_in = 1'b1;
        #(2*25ns);



        $finish;
    end
endmodule

/* verilator coverage_on */

