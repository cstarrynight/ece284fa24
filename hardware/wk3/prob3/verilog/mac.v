// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 
module mac (out, a, b, c);

parameter bw = 4;
parameter psum_bw = 9;

//...
input unsigned  [bw-1:0] a; //activation
input signed  [bw-1:0] b; //weight, not bias
input  signed [bw-1:0] c; //previous value of accumulation register
reg signed [bw:0] a_q
output [8:0] out;

a_q = {1'b0, a};
assign out = a_q*b + c;

//...
endmodule
