`timescale 1ns / 1ps

module TLC(
    input clk,reset,Xh,Xc,
    output reg Gh,Yh,Rh,Gc,Yc,Rc
    );
    
    
    
    // G->Y->R->G 
    
    parameter S0 = 3'b000;  // hgw=G, ctry=R
    parameter S1 = 3'b001;  // hgw=Y, ctry=R
    parameter S2 = 3'b010;  // hgw=R, ctry=R (Extra Safety)
    parameter S3 = 3'b011;  // hgw=R, ctry=G
    parameter S4 = 3'b100;  // hgw=R, ctry=Y
    
    reg [2:0] pr_state, nxt_state;
    reg flag = 1'b0;
    
    always@(posedge clk)begin
        if(reset)
            pr_state <= S0;
        else
            pr_state <= nxt_state;
    end
    
    // Logic for next state
    
    always@(pr_state,Xh,Xc)begin
        case(pr_state)
            S0: begin 
                if(flag == 0)
                repeat(5)@(posedge clk);
                flag =1;
                if(Xc == 1'b1)begin
                    
                    nxt_state = S1;
                    end
                else
                    nxt_state = S0;
                end
            S1: begin
                   // repeat(y2r_delay)@(posedge clk);
                    nxt_state = S2;
                    flag= 0;
                end
            S2: begin
                    //repeat(r2g_delay) @(posedge clk) ;
                    nxt_state = S3;
                end
            S3: begin 
            if(flag==1'b0)
            repeat(4) @(posedge clk);
            else
            repeat(1) @(posedge clk);
            flag = 1'b1;
            if(Xc == 1'b1 && Xh == 1'b0)
                    nxt_state = S3;
                else 
                    nxt_state = S4;
             end
            S4: begin
                    //repeat(y2r_delay) @(posedge clk);
                    nxt_state = S0;
                    flag = 1'b0;
                end
        endcase
    end
    
    always@(pr_state)begin
        case(pr_state)
            S0: begin 
                    Rh=0;Yh=0;Gh=1;Rc=1;Yc=0;Gc=0;
                end
            S1: begin 
                    Rh=0;Yh=1;Gh=0;Rc=1;Yc=0;Gc=0;
                end
            S2: begin 
                    Rh=1;Yh=0;Gh=0;Rc=1;Yc=0;Gc=0;
                end
            S3: begin 
                    Rh=1;Yh=0;Gh=0;Rc=0;Yc=0;Gc=1;
                end
            S4: begin 
                    Rh=1;Yh=0;Gh=0;Rc=0;Yc=1;Gc=0;
                end
        endcase
    end
    
    
endmodule


