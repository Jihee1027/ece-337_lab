`timescale 1ns / 10ps

module apb_uart_rx (
    input logic clk,
    input logic n_rst,
    input logic serial_in,
    input logic psel,
    input logic [2:0] paddr,
    input logic penable,
    input logic pwrite,
    input logic [7:0] pwdata,
    output logic [7:0] prdata,
    output logic psaterr
);
    logic [3:0] data_size;
    logic [13:0] bit_period;
    logic [7:0] rx_data;
    logic data_ready;
    logic overrun_error;
    logic framing_error;
    logic data_read;

    rcv_block rcv_block (
        .clk(clk),
        .n_rst(n_rst),
        .data_size(data_size),
        .bit_period(bit_period),
        .serial_in(serial_in),
        .data_read(data_read),
        .rx_data(rx_data),
        .data_ready(data_ready),
        .overrun_error(overrun_error),
        .framing_error(framing_error)
    );

    apb_subordinate apb_subordinate (
        .clk(clk),
        .n_rst(n_rst),
        .rx_data(rx_data),
        .data_ready(data_ready),
        .overrun_error(overrun_error),
        .framing_error(framing_error),
        .data_read(data_read),
        .psel(psel),
        .paddr(paddr),
        .penable(penable),
        .pwrite(pwrite),
        .pwdata(pwdata),
        .prdata(prdata),
        .psaterr(psaterr),
        .data_size(data_size),
        .bit_period(bit_period)
    );


endmodule

