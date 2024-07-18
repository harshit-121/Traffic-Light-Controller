`timescale 1ns / 1ps

module TLC_tb();

reg clk,reset,Sa,Sb;
wire Ga,Ya,Ra,Gb,Yb,Rb;

// Instantiate the TLC module
TLC t1(
    .clk(clk),
    .reset(reset),
    .Sa(Sa),
    .Sb(Sb),
    .Ga(Ga),
    .Ya(Ya),
    .Ra(Ra),
    .Gb(Gb),
    .Yb(Yb),
    .Rb(Rb)
);

// Clock generation
always #5 clk = ~clk;

// Testbench stimulus

initial begin
    // Initialize inputs
    clk = 0;
    reset = 1'b1;
    Sa = 1'b0;
    Sb = 1'b0;
    
    // Deassert reset after some time
    #30;
    reset = 1'b0;
    
    // Apply input stimuli
    #200;
    Sa = 1'b0;
    Sb = 1'b1;
    #200;
    Sa = 1'b1;
    Sb = 1'b0;
    #200;
    Sa = 1'b1;
    Sb = 1'b1;
    #200;
    Sa = 1'b0;
    Sb = 1'b0;
end

// End simulation after some time
initial begin
    #1000 $finish;
end

endmodule
