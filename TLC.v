`timescale 1ns / 1ps

module TLC(
    input clk,reset,Sa,Sb,
    output reg Ga,Ya,Ra,Gb,Yb,Rb
    );

    // G->Y->R->G 
    // A is main street, higher priority than street B
    
    parameter S0 = 3'b000;  // A = G, B = R
    parameter S1 = 3'b001;  // A = Y, B = R
    parameter S2 = 3'b010;  // A = R, B = R (Extra Safety)
    parameter S3 = 3'b011;  // A = R, B = G
    parameter S4 = 3'b100;  // A = R, B = Y
    
    reg [2:0] pr_state, nxt_state;
    reg flag = 1'b0;
    
    initial begin
    pr_state = 0;
    nxt_state = 0;
    end
    
    always@(posedge clk)begin
        if(reset)
            pr_state <= S0;
        else
            pr_state <= nxt_state;
    end
    
    // Logic for next state
    
    always@(pr_state,Sa,Sb)begin
        case(pr_state)
            S0: begin 
                    if(flag == 0)
                        repeat(5)@(posedge clk);
                    flag =1;
                    if(Sb == 1'b1)
                        nxt_state = S1;
                    else
                        nxt_state = S0;
                end
            S1: begin
                    nxt_state = S2;
                    flag= 0;
                end
            S2: begin
                    nxt_state = S3;
                end
            S3: begin 
                    if(flag==1'b0)
                        repeat(4) @(posedge clk);
                    else
                        repeat(1) @(posedge clk);
                    flag = 1'b1;
                    if(Sb == 1'b1 && Sa == 1'b0)
                        nxt_state = S3;
                    else 
                        nxt_state = S4;
                end
            S4: begin
                    nxt_state = S0;
                    flag = 1'b0;
                end
        default: nxt_state = S0;
        endcase
    end
    
    // Logic for output
    
    always@(pr_state)begin
        case(pr_state)
            S0: begin 
                    Ra=0;Ya=0;Ga=1;
                    Rb=1;Yb=0;Gb=0;
                end
            S1: begin 
                    Ra=0;Ya=1;Ga=0;
                    Rb=1;Yb=0;Gb=0;
                end
            S2: begin 
                    Ra=1;Ya=0;Ga=0;
                    Rb=1;Yb=0;Gb=0;
                end
            S3: begin 
                    Ra=1;Ya=0;Ga=0;
                    Rb=0;Yb=0;Gb=1;
                end
            S4: begin 
                    Ra=1;Ya=0;Ga=0;
                    Rb=0;Yb=1;Gb=0;
                end
       default: begin 
                    Ra=0;Ya=0;Ga=1;
                    Rb=1;Yb=1;Gb=0;
                end
        endcase
    end
    
endmodule
