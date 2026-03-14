`timescale 1ns / 10ps

module apb_subordinate #(
    // parameters
) (
    input clk, n_rst,
    input logic [7:0] rx_data,
    input logic data_ready,
    input logic overrun_error,
    input logic framing_error,
    output logic data_read,
    input logic psel,
    input logic [2:0] paddr,
    input logic penable,
    input logic pwrite,
    input logic [7:0] pwdata,
    output logic [7:0] prdata,
    output logic psaterr,
    output logic [3:0] data_size,
    output logic [13:0] bit_period
);

    logic sel0, sel1, sel2, sel3, sel4, sel6, invalid;
    logic read_en;
    logic write_en;
    logic [13:0] next_bit_period;
    logic [3:0] next_data_size;

    always_comb begin : Address_Decoder
        sel0 = (paddr == 3'd0);
        sel1 = (paddr == 3'd1);
        sel2 = (paddr == 3'd2);
        sel3 = (paddr == 3'd3);
        sel4 = (paddr == 3'd4);
        sel6 = (paddr == 3'd6);
        invalid = !(sel0 | sel1 | sel2 | sel3 | sel4 | sel6);   
    end

    always_comb begin : Read_Write_Detect_Logic
        read_en = psel & penable & ~pwrite;
        write_en = psel & penable & pwrite;
    end

    always_comb begin : Next_Bit_Period_Logic
        next_bit_period = bit_period;
        if (write_en && sel2) begin
        end
            next_bit_period [7:0] = pwdata;
        if (write_en && sel3) begin
            next_bit_period [13:8] = pwdata [5:0];
        end
    end

    always_ff @(posedge clk or negedge n_rst) begin : Bit_Period_Register
        if (!n_rst) begin
            bit_period <= 14'd10;
        end else begin
            bit_period <= next_bit_period;
        end
    end

    always_comb begin : Next_Data_Size_Logic
        next_data_size = data_size;
        if (write_en && sel4) begin
            next_data_size = pwdata [3:0];
        end
    end

    always_ff @(posedge clk or negedge n_rst) begin : Data_Size_Register
        if (!n_rst) begin
            data_size <= 4'd8;
        end else begin
            data_size <= next_data_size;
        end
    end

    always_comb begin : transaction_error_logic
        if (write_en && sel0) begin
            psaterr = 1'b1;
        end else if (write_en && sel1) begin
            psaterr = 1'b1;
        end else if (write_en && sel6) begin
            psaterr = 1'b1;
        end else if (invalid) begin
            psaterr = 1'b1;
        end else begin
            psaterr = 1'b0;
        end
    end

    always_comb begin : Data_Read_Logic
        if (read_en && sel6) begin
            data_read = 1'b1;
        end else begin
            data_read = 1'b0;
        end
    end

    always_comb begin : Read_Data_Logic
        prdata = 8'd0;
        if (read_en) begin
            if (sel0) begin
                prdata = {7'b0, data_ready};
            end else if (sel1) begin
                prdata = {6'b0, overrun_error, framing_error};
            end else if (sel2) begin
                prdata = bit_period [7:0];
            end else if (sel3) begin
                prdata = {2'b0, bit_period [13:8]};
            end else if (sel4) begin
                prdata = {4'b0, data_size};
            end else if (sel6) begin
                prdata = rx_data;
            end
        end else begin
            prdata = 8'b0;
        end
    end



endmodule

