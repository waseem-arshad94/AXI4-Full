// For Demonstration purposes only
// Code has not been fully verified or tested 
// User assumes risk
`timescale 1ns / 1ps
module t_axi4_block;

reg         s_axi_aclk;
reg         s_axi_aresetn;

reg        write;
reg [23:0] write_address;
reg [7:0]  write_burstlen;
reg [31:0]  write_data;
reg        read;
reg [23:0] read_address;
reg [7:0]  read_burstlen;
wire [31:0] read_data;

axi4_block_wrapper uut (
  .m_axi_aclk_0	(s_axi_aclk),
  .m_axi_aresetn_0	(s_axi_aresetn),
  .write_0(write),
  .write_address_0(write_address),
  .write_burstlen_0(write_burstlen),
  .write_data_0(write_data),
  .read_0(read),
  .read_address_0(read_address),
  .read_burstlen_0(read_burstlen),
  .read_data_0(read_data));

initial
begin
  s_axi_aclk = 1'b0;
end

always
  #50 s_axi_aclk = ~s_axi_aclk;

initial
begin
  s_axi_aresetn = 0;
  repeat(2) @(posedge s_axi_aclk);
  s_axi_aresetn = 1;
  repeat(10) @(posedge s_axi_aclk);
  write = 1;
  write_address	= 24'h000004;
  write_burstlen = 8'h00;
  write_data 	= 32'h55555555;
  @(posedge s_axi_aclk);
  write = 0;
  repeat(20) @(posedge s_axi_aclk);
  read	= 1;
  read_address	= 24'h000004;
  read_burstlen = 8'h00;
  @(posedge s_axi_aclk);
  read	= 0;
  repeat(20) @(posedge s_axi_aclk);
  write = 1;
  write_address	= 24'h000100;
  write_burstlen = 8'h0F;
  write_data 	= 32'h0;
  @(posedge s_axi_aclk);
  write = 0;
  repeat(40) @(posedge s_axi_aclk);
  read	= 1;
  read_address	= 24'h000100;
  read_burstlen = 8'h0F;
  @(posedge s_axi_aclk);
  read	= 0;
  repeat(40) @(posedge s_axi_aclk);
  $finish;
end
endmodule