`timescale 1ns / 1ps

module TLC_tb();

reg clk, reset, Xh, Xc;
wire Gh, Yh, Rh, Gc, Yc, Rc;

// Instantiate the TLC module
TLC t1(
    .clk(clk),
    .reset(reset),
    .Xh(Xh),
    .Xc(Xc),
    .Gh(Gh),
    .Yh(Yh),
    .Rh(Rh),
    .Gc(Gc),
    .Yc(Yc),
    .Rc(Rc)
);

// Clock generation
always #5 clk = ~clk;

// Testbench stimulus
initial begin
    // Initialize inputs
    clk = 0;
    reset = 1'b1;
    Xh = 1'b0;
    Xc = 1'b0;
    
    // Deassert reset after some time
    #30;
    reset = 1'b0;
    
    // Apply input stimuli
    #50 Xc = 1'b1;
    #80 Xc = 1'b0;
    Xh = 1'b1;
    #30 Xh=0
    #20 Xc = 1;
    #210 Xh = 1;
end

// End simulation after some time
initial begin
    #1000 $finish;
end

// Monitor signals for debugging
initial begin
    $monitor("Time: %d, clk: %b, reset: %b, Xh: %b, Xc: %b, Gh: %b, Yh: %b, Rh: %b, Gc: %b, Yc: %b, Rc: %b", 
             $time, clk, reset, Xh, Xc, Gh, Yh, Rh, Gc, Yc, Rc);
end

endmodule

