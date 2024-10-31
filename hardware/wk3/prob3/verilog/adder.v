// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 
module adder (out, a, b);


parameter psum_bw = 16;

//...
input  [psum_bw-1:0] a; //activation
input  [psum_bw-1:0] b; //weight, not bias

output [psum_bw/2+1:0] out;
    
assign out = a+b;

//...
endmodule
