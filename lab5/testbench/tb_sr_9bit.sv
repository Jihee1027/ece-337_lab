`timescale 1ns / 10ps
/* verilator coverage_off */

module tb_sr_9bit ();

    localparam CLK_PERIOD = 10ns;

    logic clk, n_rst;
    logic shift_strobe;
    logic serial_in;
    logic [7:0] packet_data;
    logic stop_bit;

    // DUT installiation
    sr_9bit dut (
        .clk(clk),
        .n_rst(n_rst),
        .shift_strobe(shift_strobe),
        .serial_in(serial_in),
        .packet_data(packet_data),
        .stop_bit(stop_bit)
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

    initial begin
        n_rst = 1;
        shift_strobe = 0;
        serial_in = 0;
        reset_dut();

        // Test 1 Power on Reset
        $display("Test 1: Reset - packet_data = %b (Expected: 11111111) - stop_bit = %b (Expected: 1)", packet_data, stop_bit);
        if (packet_data !== 8'b11111111 | stop_bit !== 1'b1) begin
            $error("Test 1 Failed - packet_data = %b - stop_bit = %b", packet_data, stop_bit);
        end

        // Test 2 Fill SR with 0
        @(negedge clk);
        shift_strobe = 1;
        repeat (9) begin
            serial_in = 0;
            @(negedge clk);
        end
        $display("Test 2: Fill 0 - packet_data = %b (Expected: 00000000) - stop_bit = %b (Expected: 0)", packet_data, stop_bit);
        if (packet_data !== 8'b00000000 | stop_bit !== 1'b0) begin
            $error("Test 2 Failed - packet_data = %b - stop_bit = %b", packet_data, stop_bit);
        end

        // Test 3 Discontinous shifting
        serial_in = 1;
        @(negedge clk);
        shift_strobe = 0;
        serial_in = 1;
        @(negedge clk);
        $display("Test 3: Discontinous - packet_data = %b (Expected: 00000000) - stop_bit = %b (Expected: 1)", packet_data, stop_bit);
        if (packet_data !== 8'b00000000 | stop_bit !== 1'b1) begin
            $error("Test 3 Failed - packet_data = %b - stop_bit = %b", packet_data, stop_bit);
        end
        
        // Test 4 Load 101010101
        shift_strobe = 1;
        serial_in = 0; @(negedge clk); //010000000
        serial_in = 1; @(negedge clk); //101000000
        serial_in = 0; @(negedge clk); //010100000
        serial_in = 1; @(negedge clk); //101010000
        serial_in = 0; @(negedge clk); //010101000
        serial_in = 1; @(negedge clk); //101010100
        serial_in = 0; @(negedge clk); //010101010
        serial_in = 1; @(negedge clk); //101010101
        serial_in = 1; @(negedge clk); //110101010
        shift_strobe = 0;
        $display("Test 4 - packet_data = %b (Expected: 10101010) - stop_bit = %b (Expected: 1)", packet_data, stop_bit);
        if (packet_data !== 8'b10101010 | stop_bit !== 1'b1) begin
            $error("Test 4 Failed - packet_data = %b - stop_bit = %b", packet_data, stop_bit);
        end
        $finish;
    end
endmodule

/* verilator coverage_on */

