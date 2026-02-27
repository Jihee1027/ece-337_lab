`timescale 1ns / 10ps

module rcu (
    input logic clk,
    input logic n_rst,
    input logic new_packet_detected,
    input logic packet_done,
    input logic framing_error,
    output logic sbc_clear,
    output logic sbc_enable,
    output logic load_buffer,
    output logic enable_timer
);
    typedef enum logic [2:0] {
        IDLE = 3'd0,
        CLR_ERR = 3'd1,
        RECEIVE = 3'd2,
        CHECK_STOP = 3'd3,
        WAIT_FE = 3'd4,
        LOAD = 3'd5
    } state_t;

    state_t state, state_next;

    // Next State Register
    always_ff @(posedge clk or negedge n_rst) begin
        if (!n_rst) begin
            state <= IDLE;
        end else begin
            state <= state_next;
        end
    end

    // Next State Logic
    always_comb begin
        state_next = state;
        sbc_clear = 1'b0;
        sbc_enable = 1'b0;
        load_buffer = 1'b0;
        enable_timer = 1'b0;
        unique case (state)
            IDLE: begin
                if (new_packet_detected) begin
                state_next = CLR_ERR;
                end
            end
            CLR_ERR: begin
                state_next = RECEIVE;
                sbc_clear = 1'b1;
            end
            RECEIVE: begin
                if (packet_done) begin
                    state_next = CHECK_STOP;
                end
                enable_timer = 1'b1;
            end
            CHECK_STOP: begin
                state_next = WAIT_FE;
                sbc_enable = 1'b1;
            end
            WAIT_FE: begin
                if (framing_error) begin
                    state_next = IDLE;
                end else begin
                    state_next = LOAD;
                end
            end
            LOAD: begin
                state_next = IDLE;
                load_buffer = 1'b1;
            end
            default: state_next = IDLE;
        endcase
    end




endmodule

