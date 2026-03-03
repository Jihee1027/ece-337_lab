`timescale 1ns / 10ps

module controller (
    input logic clk,
    input logic n_rst,
    input logic dr,
    input logic lc,
    input logic overflow,
    output logic cnt_up,
    output logic clear,
    output logic modwait,
    output logic [2:0] op,
    output logic [3:0] src1,
    output logic [3:0] src2,
    output logic [3:0] dest,
    output logic err
);
    logic busy_modwait_next;

    typedef enum logic [4:0] {
        IDLE = 5'd0,
        CHECK_DR = 5'd1,
        SHIFT4_3 = 5'd2,
        SHIFT3_2 = 5'd3,
        SHIFT2_1 = 5'd4,
        SHIFT1_0 = 5'd5,
        CLR_ACC = 5'd6,
        MUL_0 = 5'd7,
        ACC_0 = 5'd8,
        MUL_1 = 5'd9,
        ACC_1 = 5'd10,
        MUL_2 = 5'd11,
        ACC_2 = 5'd12,
        MUL_3 = 5'd13,
        ACC_3 = 5'd14,
        DONE = 5'd15,
        LOAD_F0 = 5'd16,
        LOAD_F1 = 5'd17,
        LOAD_F2 = 5'd18,
        LOAD_F3 = 5'd19,
        DR_ERROR = 5'd20,
        OVERFLOW = 5'd21,
        LOAD_F0_WAIT = 5'd22,
        LOAD_F1_WAIT = 5'd23,
        LOAD_F2_WAIT = 5'd24,
        LOAD_F3_WAIT = 5'd25,
        CHECK_DR_ERR = 5'd26
    } state_t;

    state_t state, state_next;

    always_ff @(posedge clk or negedge n_rst) begin
        if (!n_rst) begin
            state <= IDLE;
        end else begin
            state <= state_next;
        end
    end

    always_comb begin
        busy_modwait_next = !(state_next == IDLE || 
                              state_next == LOAD_F0_WAIT || 
                              state_next == LOAD_F1_WAIT || 
                              state_next == LOAD_F2_WAIT || 
                              state_next == LOAD_F3_WAIT || 
                              state_next == DONE || 
                              state_next == DR_ERROR || 
                              state_next == CHECK_DR_ERR ||
                              state_next == OVERFLOW);
    end


    always_ff @(posedge clk or negedge n_rst) begin
        if (!n_rst) begin
            modwait <= 1'b0;
        end else begin
            modwait <= busy_modwait_next;
        end
    end

    always_comb begin
        state_next = state;

        unique case (state)
            IDLE: begin
                if (lc) begin
                    state_next = LOAD_F0;
                end
                else if (dr) begin
                    state_next = CHECK_DR;
                end
            end
            CHECK_DR: begin
                if (!dr) begin
                    state_next = DR_ERROR;
                end else begin
                    state_next = SHIFT4_3;
                end
            end
            DR_ERROR: begin
                if (lc) begin
                    state_next = LOAD_F0;
                end
                else if (dr) begin
                    state_next = CHECK_DR_ERR;
                end
            end
            CHECK_DR_ERR: begin
                if (dr) begin
                    state_next = SHIFT4_3;
                end
            end
            SHIFT4_3: begin
                state_next = SHIFT3_2;
            end
            SHIFT3_2: begin
                state_next = SHIFT2_1;
            end
            SHIFT2_1: begin
                state_next = SHIFT1_0;
            end
            SHIFT1_0: begin
                state_next = CLR_ACC;
            end
            CLR_ACC: begin
                state_next = MUL_0;
            end
            MUL_0: begin
                state_next = ACC_0;
            end
            ACC_0: begin
                if (!overflow) begin
                    state_next = MUL_1;
                end else begin
                    state_next = OVERFLOW;
                end
            end
            MUL_1: begin
                state_next = ACC_1;
            end
            ACC_1: begin
                if (!overflow) begin
                    state_next = MUL_2;
                end else begin
                    state_next = OVERFLOW;
                end
            end
            MUL_2: begin
                state_next = ACC_2;
            end
            ACC_2: begin
                if (!overflow) begin
                    state_next = MUL_3;
                end else begin
                    state_next = OVERFLOW;
                end
            end
            MUL_3: begin
                state_next = ACC_3;
            end
            ACC_3: begin
                if (!overflow) begin
                    state_next = DONE;
                end else begin
                    state_next = OVERFLOW;
                end
            end
            DONE: begin
                state_next = IDLE;
            end
            LOAD_F0: begin
                state_next = LOAD_F0_WAIT;
            end
            LOAD_F0_WAIT: begin
                state_next = LOAD_F1;
            end
            LOAD_F1: begin
                state_next = LOAD_F1_WAIT;
            end
            LOAD_F1_WAIT: begin
                state_next = LOAD_F2;
            end
            LOAD_F2: begin
                state_next = LOAD_F2_WAIT;
            end
            LOAD_F2_WAIT: begin
                state_next = LOAD_F3;
            end
            LOAD_F3: begin
                state_next = LOAD_F3_WAIT;
            end
            LOAD_F3_WAIT: begin
                state_next = IDLE;
            end
            OVERFLOW: begin
                if (lc) begin
                    state_next = LOAD_F0;
                end else if (dr) begin
                    state_next = CHECK_DR;
                end
            end
            default: state_next = IDLE;
        endcase
    end

    always_comb begin
        clear = 1'd0;
        cnt_up = 1'd0;
        op = 3'd0;
        src1 = 4'd0;
        src2 = 4'd0;
        dest = 4'd0;
        err = 1'd0;

        unique case (state)
            IDLE: begin
            end
            CHECK_DR: begin
                err = 1'd0;
            end
            DR_ERROR: begin
                err = 1'd1;
            end
            CHECK_DR_ERR: begin
                err = 1'd1;
            end
            SHIFT4_3: begin
                op = 3'd1;
                src1 = 4'd3;
                dest = 4'd4;
            end
            SHIFT3_2: begin
                op = 3'd1;
                src1 = 4'd2;
                dest = 4'd3;
            end
            SHIFT2_1: begin 
                op = 3'd1;
                src1 = 4'd1;
                dest = 4'd2;
            end
            SHIFT1_0: begin
                op = 3'd2;
                src1 = 4'd0;
                dest = 4'd1;
            end
            CLR_ACC: begin
                op   = 3'd5;  
                src1 = 4'd0;
                src2 = 4'd0;
                dest = 4'd0;
            end
            MUL_0: begin
                op = 3'd6;
                src1 = 4'd1;
                src2 = 4'd5;
                dest = 4'd9;
                cnt_up = 1'd1;
            end
            ACC_0: begin
                op = 3'd4;
                src1 = 4'd0;
                src2 = 4'd9;
                dest = 4'd0;
            end
            MUL_1: begin
                op = 3'd6;
                src1 = 4'd2;
                src2 = 4'd6;
                dest = 4'd9;
            end
            ACC_1: begin
                op = 3'd5;
                src1 = 4'd0;
                src2 = 4'd9;
                dest = 4'd0;
            end
            MUL_2: begin
                op = 3'd6;
                src1 = 4'd3;
                src2 = 4'd7;
                dest = 4'd9;
            end
            ACC_2: begin
                op = 3'd4;
                src1 = 4'd0;
                src2 = 4'd9;
                dest = 4'd0;
            end
            MUL_3: begin
                op = 3'd6;
                src1 = 4'd4;
                src2 = 4'd8;
                dest = 4'd9;
            end
            ACC_3: begin
                op = 3'd5;
                src1 = 4'd0;
                src2 = 4'd9;
                dest = 4'd0;
            end
            DONE: begin
            end
            LOAD_F0: begin
                op = 3'd3;
                dest = 4'd5;
                clear = 1'd1;
            end
            LOAD_F0_WAIT: begin
            end
            LOAD_F1: begin
                op = 3'd3;
                dest = 4'd6;
            end
            LOAD_F1_WAIT: begin
            end
            LOAD_F2: begin
                op = 3'd3;
                dest = 4'd7;
            end
            LOAD_F2_WAIT: begin
            end
            LOAD_F3: begin
                op = 3'd3;
                dest = 4'd8;
            end
            LOAD_F3_WAIT: begin
            end
            OVERFLOW: begin
                err = 1'd1;
            end
        endcase
    end

endmodule

