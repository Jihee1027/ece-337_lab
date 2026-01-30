`timescale 1ns / 10ps

module edge_det #(
    parameter logic TRIG_RISE = 1'b1,
    parameter logic TRIG_FALL = 1'b0,
    parameter logic RST_VAL = 1'b0
) (
    input logic clk,
    input logic n_rst,
    input logic async_in,
    output logic sync_out,
    output logic edge_flag
);
    logic prev_sync;
    sync #(.RST_VAL(RST_VAL)) u_sync(.clk(clk), .n_rst(n_rst), .async_in(async_in), .sync_out(sync_out));

    // 1 FF
    always_ff @(posedge clk, negedge n_rst) begin
        if (!n_rst)
            prev_sync <= RST_VAL;
        else
            prev_sync <= sync_out;
    end

    // Edge Detecting Logic
    always_comb begin
        edge_flag = 1'b0;

        // Rising edge: 0 -> 1
        if (TRIG_RISE && (~prev_sync & sync_out))
            edge_flag = 1'b1;
        
        // Falling edge: 1 -> 0
        if (TRIG_FALL && (prev_sync & ~sync_out))
            edge_flag = 1'b1;
    end

endmodule

