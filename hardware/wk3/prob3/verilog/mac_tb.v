// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 


module mac_tb;

parameter bw = 4;
parameter psum_bw = 16;

reg clk = 0;

reg  [bw-1:0] a;
reg  [bw-1:0] b;
reg  [psum_bw-1:0] c;
wire [psum_bw-1:0] out;
reg  [psum_bw-1:0] expected_out = 0;

integer w_file ; // file handler
integer w_scan_file ; // file handler

integer x_file ; // file handler
integer x_scan_file ; // file handler

integer x_dec;
integer w_dec;
integer i; 
integer u; 

reg  [bw-1:0] x0;
reg  [bw-1:0] x1;
reg  [bw-1:0] x2;
reg  [bw-1:0] x3;

reg  [bw-1:0] w0;
reg  [bw-1:0] w1;
reg  [bw-1:0] w2;
reg  [bw-1:0] w3;


reg [3:0]  w [3:0];
reg [3:0]  x [3:0];
reg  [psum_bw-1:0] psum_in;
integer j; 

function [3:0] w_bin ;
  input integer  weight ;
  begin

    if (weight>-1)
     w_bin[3] = 0;
    else begin
     w_bin[3] = 1;
     weight = weight + 8;
    end

    if (weight>3) begin
     w_bin[2] = 1;
     weight = weight - 4;
    end
    else 
     w_bin[2] = 0;

    if (weight>1) begin
     w_bin[1] = 1;
     weight = weight - 2;
    end
    else 
     w_bin[1] = 0;

    if (weight>0) 
     w_bin[0] = 1;
    else 
     w_bin[0] = 0;

  end
endfunction




function [3:0] x_bin ;

  input integer  x ;
  begin

    if (x>=8) begin
        x_bin[3] = 1;
        x = x - 8;
    end 
    else begin
        x_bin[3] = 0;
    end

    if (x>=4) begin
        x_bin[2] = 1;
        x = x - 4;
    end
    else 
        x_bin[2] = 0;

    if (x>=2) begin
        x_bin[1] = 1;
        x = x - 2;
    end
    else 
        x_bin[1] = 0;

    if (x>=1) 
        x_bin[0] = 1;
    else 
        x_bin[0] = 0;
  end 
endfunction




// Below function is for verification
function [psum_bw-1:0] mac_predicted;
  input integer x0;
  input integer x1;
  input integer x2;
  input integer x3;
  input integer w0;
  input integer w1;
  input integer w2;
  input integer w3;
  input integer psum_in;

	mac_predicted = (x0*w0)+(x1*w1)+(x2*w2)+(x3*w3)+psum_in;

endfunction



mac_wrapper #(.bw(bw), .psum_bw(psum_bw)) mac_wrapper_instance (
	.clk(clk), 
        .x0(x0), 
        .w0(w0),
        .x1(x1), 
        .w1(w1),
        .x2(x2), 
        .w2(w2),
        .x3(x3), 
        .w3(w3),
        .psum_in(psum_in),
	.out(out)
); 
 

initial begin 

  w_file = $fopen("b_data.txt", "r");  //weight data
  x_file = $fopen("a_data.txt", "r");  //activation

  $dumpfile("mac_tb.vcd");
  $dumpvars(0,mac_tb);
 
  #1 clk = 1'b0;  
  #1 clk = 1'b1;  
  #1 clk = 1'b0;

  $display("-------------------- Computation start --------------------");
  

  for (i=0; i<5; i=i+1) begin  // Data lenght is 10 in the data files

     #1 clk = 1'b1;
     #1 clk = 1'b0;

     w_scan_file = $fscanf(w_file, "%d\n", w_dec);
     x_scan_file = $fscanf(x_file, "%d\n", x_dec);
     x0 = x_bin(x_dec);
     w0 = w_bin(w_dec);
     w_scan_file = $fscanf(w_file, "%d\n", w_dec);
     x_scan_file = $fscanf(x_file, "%d\n", x_dec);
     x1 = x_bin(x_dec);
     w1 = w_bin(w_dec);
     w_scan_file = $fscanf(w_file, "%d\n", w_dec);
     x_scan_file = $fscanf(x_file, "%d\n", x_dec);
     x2 = x_bin(x_dec);
     w2 = w_bin(w_dec);
     w_scan_file = $fscanf(w_file, "%d\n", w_dec);
     x_scan_file = $fscanf(x_file, "%d\n", x_dec);
     x3 = x_bin(x_dec);
     w3 = w_bin(w_dec);          


      x[0] = x0;
      x[1] = x1;
      x[2] = x2;
      x[3] = x3;

      w[0] = w0;
      w[1] = w1;
      w[2] = w2;
      w[3] = w3;

     psum_in = expected_out;
    //Prob 2
    //  a = x_bin(x_dec); // unsigned number
    //  b = w_bin(w_dec); // signed number
    //  c = expected_out;

    expected_out = mac_predicted(x[0], x[1], x[2], x[3], w[0], w[1], w[2], w[3], psum_in);


  end



  #1 clk = 1'b1;
  #1 clk = 1'b0;

  $display("-------------------- Computation completed --------------------");

  #10 $finish;


end

endmodule




