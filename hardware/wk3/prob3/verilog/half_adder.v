// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 
module half_adder (out, a, b);


parameter psum_bw = 16;

//...
input  signed [psum_bw/2:0] a; //activation
input  signed [psum_bw/2:0] b; //weight, not bias

output [psum_bw/2:0] out;
    
assign out = a+b;

//...
endmodule
