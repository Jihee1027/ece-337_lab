`timescale 1ns / 10ps

module stoplight (
    input logic clk, n_rst,
    input logic carstart, carstop, 
    input logic walkstart, walkstop,
    output logic rled, yled, gled
);  

    // Write code here!
    typedef enum logic [2:0] {
        GO = 3'd0,
        CARSLOW = 3'd1,
        WALKSLOW = 3'd2,
        CARSTOP = 3'd3,
        WALKSTOP = 3'd4
    } state_t;

    state_t state, state_next;

    always_ff @(posedge clk or negedge n_rst) begin
        if (!n_rst) begin
            state <= CARSTOP;
        end else begin
            state <= state_next;
        end
    end

    always_comb begin
        state_next = state;
        rled = 1'b0;
        gled = 1'b0;
        yled = 1'b0;
        unique case (state)
            CARSTOP: begin
                rled = 1'b1;
                if (walkstop) begin
                    state_next = WALKSTOP;
                end else if (carstart) begin
                    state_next = GO;
                end
            end
            WALKSTOP: begin
                rled = 1'b1;
                if (walkstart) begin
                    state_next = GO;
                end
            end
            GO: begin
                gled = 1'b1;
                if (carstop) begin
                    state_next = CARSLOW;
                end else if (walkstop) begin
                    state_next = WALKSLOW;
                end
            end
            CARSLOW: begin
                yled = 1'b1;
                if (!walkstop) begin
                    state_next = CARSTOP;
                end else begin
                    state_next = WALKSTOP;
                end
            end
            WALKSLOW: begin
                yled = 1'b1;
                state_next = WALKSTOP;
            end
        endcase
    end

endmodule

