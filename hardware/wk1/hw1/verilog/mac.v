// Code your design here
// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 
module mac (out, A, B, format, acc, clk, reset);

parameter bw = 8;
parameter psum_bw = 16;

input clk;
input acc;
input reset;
input format;

input signed [bw-1:0] A;
input signed [bw-1:0] B;

output signed [psum_bw-1:0] out;

reg signed [psum_bw-1:0] psum_q;
reg signed [bw-1:0] a_q;
reg signed [bw-1:0] b_q;

assign out = psum_q;

// Your code goes here
  

  
  always @ (posedge clk or posedge reset) begin
	a_q = A;
    b_q = B;
    if (reset) begin
        psum_q <= 0; 
    end
  	if(acc) begin
        
        if(format) begin //mac in a sign and magnitude system
          
          psum_q <= psum_q + {(a_q[bw-1] ^ b_q[bw-1]) ? 1'b1 : 1'b0, a_q[bw-2:0] * b_q[bw-2:0]};
        end

        else begin //mac operation in a signed 2’s complement number system
          psum_q <= psum_q + a_q * b_q;    
        end

    end
end
endmodule

