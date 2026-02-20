`timescale 1ns / 10ps

module fsm (
    input logic clk,
    input logic n_rst,
    input logic start,
    input logic end_packet,
    input logic done,
    input logic [7:0] data_const,
    input logic [7:0] data_dyn,
    output logic const_select,
    output logic load,
    output logic [7:0] data_out 
);

    typedef enum logic [2:0] { 
        IDLE = 3'd0,
        SOF_LOAD = 3'd1,
        SOF_SEND = 3'd2,
        DATA_LOAD = 3'd3,
        DATA_SEND = 3'd4,
        EOF_LOAD = 3'd5,
        EOF_SEND = 3'd6
    } state_t;

    state_t state, state_next;

    // Control bundle
    typedef struct packed {
        logic load;
        logic const_select;
        logic use_const;
    } ctrl_t;

    ctrl_t ctrl;

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

        unique case (state)
            IDLE: begin
                if (start) begin
                    state_next = SOF_LOAD;
                end
            end
            SOF_LOAD: begin
                state_next = SOF_SEND;
            end
            SOF_SEND: begin
                if (done) begin
                    state_next = DATA_LOAD;
                end
            end
            DATA_LOAD: begin
                state_next = DATA_SEND;
            end
            DATA_SEND: begin
                if (done && end_packet) begin
                    state_next = EOF_LOAD;
                end else if (done && !end_packet) begin
                    state_next = DATA_LOAD;
                end
            end
            EOF_LOAD: begin
                state_next = EOF_SEND;
            end
            EOF_SEND: begin
                if (done) begin
                    state_next = IDLE;
                end
            end
            default: state_next = IDLE;
        endcase
    end

    // Control Logic
    always_comb begin
        ctrl = '0;
        unique case (state)
            SOF_LOAD: begin
                ctrl.load = 1'b1;
                ctrl.use_const = 1'b1;
                ctrl.const_select = 1'b0;
            end
            DATA_LOAD: begin
                ctrl.load = 1'b1;
                ctrl.use_const = 1'b0;
            end
            EOF_LOAD: begin
                ctrl.load = 1'b1;
                ctrl.use_const = 1'b1;
                ctrl.const_select = 1'b1;
            end
            default: begin
            end
        endcase
    end

    // Datapath Logic
    always_comb begin
        if (ctrl.use_const) begin
            data_out = data_const;
        end else begin
            data_out = data_dyn;
        end
    end

    // Outputs
    assign load = ctrl.load;
    assign const_select = ctrl.const_select;

endmodule

