`timescale 1ns / 10ps
/* verilator coverage_off */

module tb_magnitude ();
    logic in;
    logic out;

    magnitude dut (.*);

    initial begin
        in = 17'sh1FFFF;
       
        $finish;
    end
endmodule

/* verilator coverage_on */

