`timescale 1ns / 10ps

module tb_adder_32bit ();

    // -- allows the testbench to have different DUTs. DO NOT MODIFY --
    parameter adder_type = 0;

    logic [31:0] a;
    logic [31:0] b;
    logic carry_in;
    logic [31:0] sum;
    logic carry_out;

    /* verilator lint_off GENUNNAMED */
    generate
        if(adder_type == 1)      adder_32bit_param #() DUT (.a(a), .b(b), .carry_in(carry_in), .sum(sum), .carry_out(carry_out));
        else if(adder_type == 2) adder_32bit_auto  #() DUT (.a(a), .b(b), .carry_in(carry_in), .sum(sum), .carry_out(carry_out));
        else initial begin
            $display("ERROR: Incorrect adder type specified: %d", adder_type);
            $stop;
        end
    endgenerate
    /* verilator lint_on GENUNNAMED */
    
    // -- student code below this line --
    localparam TEST_DELAY = 5ns;
    localparam NUM_TEST_CASES = 11;

    typedef struct {
        logic [31:0] a;
        logic [31:0] b;
        logic carry_in;
        logic [31:0] exp_sum;
        logic exp_carry_out;
    } testVector_t;

    testVector_t test_vec [NUM_TEST_CASES];

    task set_tv;
        input logic [31:0] tv_a;
        input logic [31:0] tv_b;
        input logic tv_cin;
        input integer idx;
    begin
        automatic logic [32:0] tv_sum;

        tv_sum = tv_a + tv_b + tv_cin;
    
        test_vec[idx].a = tv_a;
        test_vec[idx].b = tv_b;
        test_vec[idx].carry_in = tv_cin;
        test_vec[idx].exp_sum = tv_sum[31:0];
        test_vec[idx].exp_carry_out = tv_sum[32];
    end
    endtask

    initial begin
        integer i;
        logic [32:0] expected_result;
        a = 0;
        b = 0;
        carry_in = 0;
        #(1ns);
        set_tv(32'h00000000, 32'h00000000, 0, 0);   // 0 + 0
        set_tv(32'hFFFFFFFF, 32'h00000000, 0, 1);   // max + 0
        set_tv(32'hFFFFFFFF, 32'h00000001, 0, 2);   // carry out
        set_tv(32'hAAAAAAAA, 32'h55555555, 0, 3);   // alternating bits
        set_tv(32'h12345678, 32'h87654321, 1 ,4);   // random + carry_in
        set_tv(32'h80000000, 32'h80000000, 0, 5);   // MSB Carry
        set_tv(32'h00000001, 32'h00000001, 0, 6);   // LSB Carry
        set_tv(32'h7FFFFFFF, 32'h00000001, 0, 7);   // ripple carry
        set_tv(32'hFFFFFFFF, 32'hFFFFFFFF, 0, 8);
        set_tv(32'h7AAAAAAA, 32'h00000001, 0, 9);
        set_tv(32'h80000000, 32'h00000001, 0, 10);
        

        // Loop through all test vectors
        for (i = 0; i < NUM_TEST_CASES; i = i + 1) begin
            a = test_vec[i].a;
            b = test_vec[i].b;
            carry_in = test_vec[i].carry_in;
            
            #(TEST_DELAY);

            expected_result = {test_vec[i].exp_carry_out, test_vec[i].exp_sum};
            
            if ({carry_out, sum} === expected_result) begin
                $display("Test %d PASSED: %h + %h + %b = %h (carry_out: %b)", 
                    i, test_vec[i].a, test_vec[i].b, test_vec[i].carry_in, sum, carry_out);
            end else begin
                $display("Test %d FAILED: %h + %h + %b", i, test_vec[i].a, test_vec[i].b, test_vec[i].carry_in);
                $display("  Expected: sum = %h, carry_out = %b", test_vec[i].exp_sum, test_vec[i].exp_carry_out);
                $display("  Got:      sum = %h, carry_out = %b", sum, carry_out);
            end
        end

        $finish;
    end

endmodule

