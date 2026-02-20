`timescale 1ns / 10ps

module flex_counter #(
    parameter SIZE = 8
) (
    input logic clk,
    input logic n_rst,
    input logic clear,
    input logic count_enable,
    input logic [SIZE-1:0] rollover_val,
    output logic [SIZE-1:0] count_out,
    output logic rollover_flag
);
    logic [SIZE-1:0] count_next;
    logic rollover_next;

    always_comb begin
        if (clear) begin
            count_next = '0;
        end else if (count_enable) begin
            if (count_out >= rollover_val) begin
                count_next = '0; count_next[0] = 1'b1;
            end else begin
                count_next = count_out + 1;
            end
        end else begin
            count_next = count_out;
        end
    end

     // Optimized
    always_comb begin
        rollover_next = 1'b0;
        if (!clear) begin
            rollover_next = (count_next == rollover_val);
        end
    end

    always_ff @(posedge clk or negedge n_rst) begin
        if (!n_rst) begin
            count_out <= '0;
            rollover_flag <= 1'b0;
        end else begin
            count_out <= count_next;
            rollover_flag <= rollover_next;
        end
    end

    // always_comb begin
    //     if (count_out == rollover_val) begin
    //         rollover_flag = 1;
    //     end else begin
    //         rollover_flag = 0;
    //     end
    // end


endmodule

