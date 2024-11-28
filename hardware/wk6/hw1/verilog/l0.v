// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 
module l0 (clk, in, out, rd, wr, o_full, reset, o_ready);

  parameter row  = 8;
  parameter bw = 4;

  input  clk;
  input  wr;
  input  rd;
  input  reset;
  input  [row*bw-1:0] in;
  output [row*bw-1:0] out;
  output o_full;
  output o_ready;

  wire [row-1:0] empty;
  wire [row-1:0] full;
  reg [row-1:0] rd_en;
  
  genvar i;

  assign o_ready = ~empty ;
  assign o_full  = full ;


  for (i=0; i<row ; i=i+1) begin : row_num
      fifo_depth64 #(.bw(bw)) fifo_instance (
	 .rd_clk(clk),
	 .wr_clk(clk),
	 .rd(rd_en[i]),
	 .wr(wr),
    .o_empty(empty[i]),
    .o_full(full[i]),
	 .in(in[bw*(i+1)-1:bw*i]),
	 .out(out[bw*(i+1)-1:bw*i]),
    .reset(reset));
  end


  always @ (posedge clk) begin
   if (reset) begin
      rd_en <= 8'b00000000;
   end
   else

      // /////////////// version1: read all row at a time ////////////////
      //rd_en <= 8'b{rd} //rd decides for all 8 rows
      // ///////////////////////////////////////////////////////

      $display("else tbd");

      // //////////////// version2: read 1 row at a time /////////////////
      rd_en <= {rd_en[row-2:0],rd}; //shift left and add rd for whether to rd next row or not
      // ///////////////////////////////////////////////////////
   end

endmodule