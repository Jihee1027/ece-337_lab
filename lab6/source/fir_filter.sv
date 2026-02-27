`timescale 1ns / 10ps

module fir_filter (
    input logic clk,
    input logic n_rst,
    input logic [15:0] sample_data,
    input logic [15:0] fir_coefficient,
    input logic load_coeff,
    input logic data_ready,
    output logic one_k_samples,
    output logic modwait,
    output logic [15:0] fir_out,
    output logic err
);



endmodule

