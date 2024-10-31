// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 
module mac_wrapper (
	.clk(clk), 
        .x0(x[0]), 
        .w0(w[0]),
        .x1(x[1]), 
        .w1(w[1]),
        .x2(x[2]), 
        .w2(w[2]),
        .x3(x[3]), 
        .w3(w[3]),
        .c(psum_in),
	.out(out)
); 

parameter bw = 4;
parameter psum_bw = 16;

output [psum_bw-1:0] out;
input  [bw-1:0] a;
input  [bw-1:0] b;
input  [psum_bw-1:0] c;
input  clk;


input  [bw-1:0] x0;
input  [bw-1:0] x1;
input  [bw-1:0] x2;
input  [bw-1:0] x3;

input  [bw-1:0] w0;
input  [bw-1:0] w1;
input  [bw-1:0] w2;
input  [bw-1:0] w3;


input [3:0]  w [3:0];
input [3:0]  x [3:0];
input [psum_bw-1:0] psum_in;
integer j; 

reg    [bw-1:0] a_q;
reg    [bw-1:0] b_q;
reg    [psum_bw-1:0] c_q;
reg [psum_bw-1:0] out01;
reg [psum_bw-1:0] out0;
reg [psum_bw-1:0] out1;
reg [psum_bw-1:0] out23;
reg [psum_bw-1:0] out2;
reg [psum_bw-1:0] out3;

mac0 #(.bw(bw), .psum_bw(psum_bw)) mac_instance (
        .a(x0), 
        .b(w0),
        .c(0),
	.out(out0)
); 

mac1 #(.bw(bw), .psum_bw(psum_bw)) mac_instance (
        .a(x1), 
        .b(w1),
        .c(out0),
	.out(out1)
); 

mac2 #(.bw(bw), .psum_bw(psum_bw)) mac_instance (
        .a(x2), 
        .b(w2),
        .c(out1),
	.out(out2)
); 

mac3 #(.bw(bw), .psum_bw(psum_bw)) mac_instance (
        .a(x3), 
        .b(w3),
        .c(out2),
	.out(out3)
); 

mac4 #(.bw(bw), .psum_bw(psum_bw)) mac_instance (
        .a(1), 
        .b(out3),
        .c(psum_in),
	.out(out)
); 

endmodule
