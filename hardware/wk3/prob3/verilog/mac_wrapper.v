// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 
module mac_wrapper (
	clk, 
        x0, 
        w0,
        x1, 
        w1,
        x2, 
        w2,
        x3, 
        w3,
        psum_in,
	out
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

input [psum_bw-1:0] psum_in;
integer j; 

reg    [bw-1:0] a_q;
reg    [bw-1:0] b_q;
reg    [psum_bw-1:0] c_q;
wire [psum_bw-1:0] out0, out1, out2, out3, outf;
wire [psum_bw/2-1:0] out01, out23;

mac #(.bw(bw), .psum_bw(psum_bw)) mac_instance0 (
        .a(x0), 
        .b(w0),
        .c(0),
	.out(out0)
); 

mac #(.bw(bw), .psum_bw(psum_bw)) mac_instance1 (
        .a(x1), 
        .b(w1),
        .c(0),
	.out(out1)
); 

mac #(.bw(bw), .psum_bw(psum_bw)) mac_instance2 (
        .a(x2), 
        .b(w2),
        .c(0),
	.out(out2)
); 

mac #(.bw(bw), .psum_bw(psum_bw)) mac_instance3 (
        .a(x3), 
        .b(w3),
        .c(0),
	.out(out3)
); 

adder #(.psum_bw(psum_bw)) adder_instance1 (
        .a(out0), 
        .b(out1),
	.out(out01)
); 

adder #(.psum_bw(psum_bw)) adder_instance2 (
        .a(out2), 
        .b(out3),
	.out(out23)
); 

adder #(.psum_bw(psum_bw)) adder_instance3 (
        .a(out01), 
        .b(out23),
	.out(outf)
); 

adder #(.psum_bw(psum_bw)) adder_instance4 (
        .a(outf), 
        .b(psum_in),
	.out(out)
); 

endmodule
