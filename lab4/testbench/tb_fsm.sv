`timescale 1ns / 10ps
/* verilator coverage_off */

module tb_fsm ();

    localparam CLK_PERIOD = 10ns;

    logic clk, n_rst;
    logic start, end_packet, done;
    logic [7:0] data_dyn;

    logic const_select;
    logic load;
    logic [7:0] data_out;
    logic [7:0] data_const;
    assign data_const = const_select ? 8'hBB : 8'hAA;

    fsm dut (
        .clk(clk),
        .n_rst(n_rst),
        .start(start),
        .end_packet(end_packet),
        .done(done),
        .data_const(data_const),
        .data_dyn(data_dyn),
        .const_select(const_select),
        .load(load),
        .data_out(data_out)
    );

    always begin
        clk = 0; #(CLK_PERIOD/2.0);
        clk = 1; #(CLK_PERIOD/2.0);
    end

    int error_count = 0;

    task automatic show;
    begin
        $display("t=%0t state=%s start=%0b done=%0b end_packet=%0b load=%0b const_select=%0b data_out=%h data_dyn=%h",
                 $time, dut.state.name(), start, done, end_packet, load, const_select, data_out, data_dyn);
    end
    endtask

    task automatic tick;
    begin
        @(posedge clk);
        #1;
        show();
    end
    endtask

    task automatic expect_state_name(input string exp_name);
        string got;
    begin
        got = dut.state.name();
        if (got != exp_name) begin
            $error("State mismatch! expected=%s got=%s @time=%0t", exp_name, got, $time);
            error_count++;
        end
    end
    endtask

    task automatic check_outputs;
        string s;
    begin
        s = dut.state.name();

        if (s == "SOF_LOAD") begin
            if (load !== 1'b1) begin $error("SOF_LOAD: load should be 1"); error_count++; end
            if (const_select !== 1'b0) begin $error("SOF_LOAD: const_select should be 0"); error_count++; end
            if (data_out !== 8'hAA) begin $error("SOF_LOAD: data_out should be AA"); error_count++; end
        end
        else if (s == "DATA_LOAD") begin
            if (load !== 1'b1) begin $error("DATA_LOAD: load should be 1"); error_count++; end
            if (data_out !== data_dyn) begin $error("DATA_LOAD: data_out should equal data_dyn"); error_count++; end
        end
        else if (s == "EOF_LOAD") begin
            if (load !== 1'b1) begin $error("EOF_LOAD: load should be 1"); error_count++; end
            if (const_select !== 1'b1) begin $error("EOF_LOAD: const_select should be 1"); error_count++; end
            if (data_out !== 8'hBB) begin $error("EOF_LOAD: data_out should be BB"); error_count++; end
        end
        else begin
            if (load !== 1'b0) begin
                $error("%s: load should be 0 in non-load state", s);
                error_count++;
            end
        end
    end
    endtask

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
        start = 0;
        done = 0;
        end_packet = 0;
        data_dyn = 8'h11;

        reset_dut;

        tick();
        expect_state_name("IDLE");
        check_outputs();

        // IDLE -> SOF_LOAD
        start = 1;
        tick();
        start = 0;
        expect_state_name("SOF_LOAD");
        check_outputs();

        // SOF_LOAD -> SOF_SEND (unconditional)
        tick();
        expect_state_name("SOF_SEND");
        check_outputs();

        // SOF_SEND self-loop (done=0)
        done = 0;
        tick();
        expect_state_name("SOF_SEND");
        check_outputs();

        // SOF_SEND -> DATA_LOAD (done=1)
        done = 1;
        data_dyn = 8'h33;
        tick();
        done = 0;
        expect_state_name("DATA_LOAD");
        check_outputs();

        // DATA_LOAD -> DATA_SEND (unconditional)
        tick();
        expect_state_name("DATA_SEND");
        check_outputs();

        // DATA_SEND self-loop (done=0)
        done = 0;
        tick();
        expect_state_name("DATA_SEND");
        check_outputs();

        // DATA_SEND -> DATA_LOAD (done=1, end_packet=0)
        done = 1;
        end_packet = 0;
        data_dyn = 8'h44;
        tick();
        done = 0;
        expect_state_name("DATA_LOAD");
        check_outputs();

        // DATA_LOAD -> DATA_SEND
        tick();
        expect_state_name("DATA_SEND");
        check_outputs();

        // DATA_SEND -> EOF_LOAD (done=1, end_packet=1)
        done = 1;
        end_packet = 1;
        tick();
        done = 0;
        end_packet = 0;
        expect_state_name("EOF_LOAD");
        check_outputs();

        // EOF_LOAD -> EOF_SEND/EOF_WAIT (unconditional; allow either name)
        tick();
        expect_state_name("EOF_SEND");
        check_outputs();

        // EOF_SEND/EOF_WAIT self-loop (done=0) (allow either)
        done = 0;
        tick();
        expect_state_name("EOF_SEND");
        check_outputs();

        // EOF_SEND/EOF_WAIT -> IDLE (done=1)
        done = 1;
        tick();
        done = 0;
        expect_state_name("IDLE");
        check_outputs();

        if (error_count == 0)
            $display("PASS: tb_fsm done.");
        else
            $display("FAIL: tb_fsm done with %0d errors.", error_count);

        $finish;
    end

endmodule

/* verilator coverage_on */
