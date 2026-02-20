`timescale 1ns / 10ps
/* verilator coverage_off */

module tb_flex_counter ();

    localparam CLK_PERIOD = 10ns;
    localparam int SIZE = 4;

    logic clk, n_rst;
    logic clear;
    logic count_enable;
    logic [SIZE-1:0] rollover_value;
    logic [SIZE-1:0] count_out;
    logic rollover_flag;
    int ones;

    // DUT Installation
    flex_counter #(.SIZE(SIZE)) dut (
        .clk(clk),
        .n_rst(n_rst),
        .clear(clear),
        .count_enable(count_enable),
        .rollover_val(rollover_value),
        .count_out(count_out),
        .rollover_flag(rollover_flag)
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
        n_rst = 0;
        clear = 0;
        count_enable = 0;
        rollover_value = 4'd7;

        repeat (2) @(posedge clk);
        n_rst = 1;
        repeat (1) @(posedge clk);

        // Test 1: Power-on-Reset
        $display("Test 1: Reset - count_out = %b (Expected: 0000)", count_out);

        if (count_out !== '0) begin
            $error("RESET FAILED: count_out = %b", count_out);
        end


        // Test 2: Rollover for a rollover value that is not a power of two
        rollover_value = 4'd7;

        @(negedge clk);
        count_enable = 1;
        repeat (7) begin
            @ (posedge clk);
            #1ps;
        end
        $display("Test 2a: At rollover - count_out = %b (Expected: 0111)", count_out);
        if(count_out !== 4'd7)
            $error("ROLLOVER VALUE NOT REACHED: count_out = %b", count_out);
        
        @(posedge clk);
        #1ps;
        $display("Test 2b: After rollover - count_out = %b (Expected: 0001)", count_out);
        if (count_out !== 4'd1)
            $error("ROLLOVER FAILED: count_out = %b", count_out);
        
        count_enable = 0;

        // Test 3: Continuous counting
        reset_dut;
        clear = 0;
        rollover_value = 4'd7;

        @(negedge clk);
        count_enable = 1;

        for (int i =1; i <= 5; i++) begin
            @(posedge clk); 
            #1ps;
            $display("Test 3: cycle %0d: count_out=%0d (EXpected: %0d)", i, count_out, i);
            if (count_out !== i[SIZE-1:0])
                $error("CONT COUNT FAILED at i=%0d: count_out=%0d", i, count_out);
        end

        // Rollover Continous Counting
        repeat (2) begin
            @(posedge clk); 
            #1ps;
        end

        $display("Test 3: at rollover: count_out=%0d (Expected: 7)", count_out);
        if (count_out !== rollover_value)
            $error("DID NOT REACH ROLLOVER: count_out=%0d", count_out);
        if (rollover_flag !== 1'b1)
            $error("ROLLOVER FLAG FAILED: flag=%b", rollover_flag);
        
        @(posedge clk);
        #1ps;
        $display("Test 3: after rollover: count_out=%0d (Expected: 1)", count_out);

        if (count_out !== 4'd1)
            $error("ROLLOVER FAILED: count_out=%0d", count_out);
        
        // Test 4: Discontinous Counting
        clear = 0;
        count_enable = 0;
        rollover_value = 4'd7;
        reset_dut;
        @(negedge clk);
        count_enable = 1;
        @(posedge clk); #1ps;
        @(posedge clk); #1ps;
        $display("Test 4: before disable: count_out=%0d (Expected: 2)", count_out);
        if (count_out !== 4'd2)
            $error("PREP FAILED: count_out=%0d", count_out);
        @(negedge clk);
        count_enable = 0;
        @(posedge clk); #1ps;
        $display("Test 4: disabled hold 1: count_out=%0d (Expected: 2)", count_out);
        if (count_out !== 4'd2)
            $error("HOLD FAILED (1): count_out=%0d", count_out);
        @(posedge clk); #1ps;
        $display("Test 4: disabled hold 2: count_out=%0d (Expected: 2)", count_out);
        if (count_out !== 4'd2)
            $error("HOLD FAILED (2): count_out=%0d", count_out);
        @(negedge clk);
        count_enable = 1;
        @(posedge clk); #1ps;
        $display("Test 4: re-enabled: count_out=%0d (Expected: 3)", count_out);
        if (count_out !== 4'd3)
            $error("RE-ENABLE FAILED: count_out=%0d", count_out);
        count_enable = 0;

        // Test 5:Clearing while counting to check clear vs. count enable priority
        clear = 0;
        count_enable = 0;
        rollover_value = 4'd7;
        reset_dut;
        @(posedge clk); #1ps;
        @(negedge clk);
        count_enable = 1;
        @(posedge clk); #1ps;  // 1
        @(posedge clk); #1ps;  // 2
        $display("Test 5: before clear: count_out=%0d (Expected: 2)", count_out);
        if (count_out !== 4'd2)
            $error("PREP FAILED: count_out=%0d", count_out);
        @(negedge clk);
        clear = 1;
        count_enable = 1;
        @(posedge clk); #1ps;
        $display("Test 5: clear asserted w/ enable=1: count_out=%0d (Expected: 0)", count_out);
        if (count_out !== 4'd0)
            $error("CLEAR PRIORITY FAILED: count_out=%0d", count_out);
        @(negedge clk);
        clear = 0;
        count_enable = 1;
        @(posedge clk); #1ps;
        $display("Test 5: after clear released: count_out=%0d (Expected: 1)", count_out);
        if (count_out !== 4'd1)
            $error("POST-CLEAR COUNT FAILED: count_out=%0d", count_out);

        // Extra Toggles:
        @(negedge clk); rollover_value = 4'd7;
        @(negedge clk); rollover_value = 4'd8;
        @(negedge clk); rollover_value = 4'd15;
        @(negedge clk); rollover_value = 4'd0;
        @(posedge clk); #1ps; 

        rollover_value = 4'd12;
        count_enable = 1;
        repeat (12) @(posedge clk); #1ps;

        // Test 6: Rollover Edge Case
        clear = 0; count_enable = 0; rollover_value = 4'd12; reset_dut; 
        @(negedge clk); count_enable = 1;
        repeat (10) begin
            @(posedge clk); #1ps;
        end
        $display("Test 6a: before changing rollover_value: count_out=%0d (Expected: 10)", count_out);
        if (count_out !== 4'd10)
            $error("EDGE PREP FAILED: count_out=%0d", count_out);
        @(negedge clk); rollover_value = 4'd5; 
        #1ps;
        $display("Test 6b: immediately after lowering rollover_value: count_out=%0d rollover=%0d flag=%b", count_out, rollover_value, rollover_flag);
        @(posedge clk); #1ps;
        $display("Test 6c: after edge recovery: count_out=%0d (Expected: 1)", count_out);  
        if (count_out !== 4'd1)
            $error("EDGE CASE FAILED: count_out=%0d (Expected: 1)", count_out);
        $display("Test 6d: after recovery flag=%b (Expected: 0)", rollover_flag);
        if (rollover_flag !== 1'b0)
            $error("EDGE FLAG AFTER RECOVERY FAILED: rollover_flag=%b (Expected: 0)", rollover_flag);
        count_enable = 0;
        // Test 7: Discontinuous Rollover (flag pulse check)
        $display("\nTest 7: Discontinuous rollover (flag pulse check)");
        clear = 0;
        rollover_value = 4'd7;
        count_enable = 0;
        reset_dut;

        @(negedge clk);
        count_enable = 1;

        // rollover 직전(6)까지 가기
        repeat (6) begin
          @(posedge clk); #1ps;
        end
        $display("Test 7a: reached 6: count_out=%0d (Expected: 6), flag=%b (Expected: 0)", count_out, rollover_flag);
        if (count_out !== 4'd6) $error("T7 PREP FAILED: count_out=%0d", count_out);
        if (rollover_flag !== 1'b0) $error("T7 FLAG EARLY: flag=%b", rollover_flag);

        // 여기서 enable 끄고 hold
        @(negedge clk);
        count_enable = 0;

        // hold 동안 flag가 0 유지되는지 확인
        repeat (2) begin
          @(posedge clk); #1ps;
          $display("Test 7b: hold: count_out=%0d (Expected: 6), flag=%b (Expected: 0)", count_out, rollover_flag);
          if (count_out !== 4'd6) $error("T7 HOLD COUNT FAILED: %0d", count_out);
          if (rollover_flag !== 1'b0) $error("T7 HOLD FLAG FAILED: %b", rollover_flag);
        end

        // enable 다시 켜기
        @(negedge clk);
        count_enable = 1;

        // 다음 클럭에서 "도달/예측" 정의에 맞게 flag가 1번만 뜨는지 확인
        @(posedge clk); #1ps;
        $display("Test 7c: re-enable next: count_out=%0d flag=%b", count_out, rollover_flag);

        ones = 0;
        repeat (3) begin
          @(posedge clk); #1ps;
          ones += (rollover_flag === 1'b1);
        end
        if (ones > 1) $error("T7 FLAG PULSE WIDTH FAILED: flag stayed high %0d cycles", ones);

        $display("\nTest 7d: disable around rollover boundary");

        clear=0; rollover_value=4'd7; count_enable=0; reset_dut; 
        @(negedge clk); count_enable=1;

        // 7 도달까지
        repeat(7) @(posedge clk); #1ps;
        $display("  reached 7: count_out=%0d flag=%b", count_out, rollover_flag);

        // 바로 disable
        @(negedge clk); count_enable=0;
        @(posedge clk); #1ps;
        $display("  disabled after 7: count_out=%0d flag=%b (expect hold at 7 OR already rolled depending spec)", count_out, rollover_flag);

        // 다시 enable
        @(negedge clk); count_enable=1;
        @(posedge clk); #1ps;
        $display("  re-enabled: count_out=%0d flag=%b (expect rollover behavior continues cleanly)", count_out, rollover_flag);

        $display("\nTest 7e: change rollover_value while disabled");

        reset_dut; clear=0; rollover_value=4'd12; count_enable=0;
        @(negedge clk); count_enable=1;

        // count_out 10까지
        repeat(10) @(posedge clk); #1ps;
        @(negedge clk); count_enable=0;

        // disable 중 rollover 낮추기 (out-of-bounds)
        rollover_value = 4'd5;
        @(posedge clk); #1ps;
        $display("  disabled + lowered rollover: count_out=%0d rollover=%0d flag=%b", count_out, rollover_value, rollover_flag);

        // 다시 enable
        @(negedge clk); count_enable=1;
        @(posedge clk); #1ps;
        $display("  re-enabled: count_out=%0d flag=%b", count_out, rollover_flag);

        $display("\nTest 7e: change rollover_value while disabled");

        reset_dut; clear=0; rollover_value=4'd12; count_enable=0;
        @(negedge clk); count_enable=1;

        // count_out 10까지
        repeat(10) @(posedge clk); #1ps;
        @(negedge clk); count_enable=0;

        // disable 중 rollover 낮추기 (out-of-bounds)
        rollover_value = 4'd5;
        @(posedge clk); #1ps;
        $display("  disabled + lowered rollover: count_out=%0d rollover=%0d flag=%b", count_out, rollover_value, rollover_flag);

        // enable again
        @(negedge clk); count_enable=1;
        @(posedge clk); #1ps;
        $display("  re-enabled: count_out=%0d flag=%b", count_out, rollover_flag);

        $finish;
    end
endmodule

/* verilator coverage_on */

