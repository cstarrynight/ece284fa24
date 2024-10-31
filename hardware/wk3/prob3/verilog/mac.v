// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 
module mac (out, a, b, c);

parameter bw = 4;
parameter psum_bw = 16;

//...
input unsigned  [bw-1:0] a; //activation
input signed  [bw-1:0] b; //weight, not bias
input  [psum_bw-1:0] c; //previous value of accumulation register
output out;
    
assign out = a*b + c;

//...
endmodule
