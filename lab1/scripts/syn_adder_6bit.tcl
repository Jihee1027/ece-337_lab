proc synthesize_design {} {
    ### configure the design requirements ###
    set_max_delay 0.78 -from "b[0]" -to "carry_out"
    # set_max_area <area>
    # set_max_total_power <power> mW
    # create_clock clk -name clk -period <clock period in ns>

    ### compile the design into the standard cell library ###
    compile -map_effort medium
}

