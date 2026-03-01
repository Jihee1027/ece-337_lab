`timescale 1ns / 10ps

module magnitude (
    input logic [16:0] in,
    output logic [15:0] out
);
    logic unused;
    assign out = in [16:1];
    assign unused = in [0];
    
endmodule

