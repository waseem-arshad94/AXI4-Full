// For Demonstration purposes only
// Code has not been fully verified or tested 
// User assumes risk
`timescale 1ns / 1ps
module t_axi4_master;

reg         s_axi_aclk;
reg         s_axi_aresetn;

wire [2:0]  s_axi_awid;
wire        s_axi_awvalid;
wire        s_axi_awready;
wire [23:0] s_axi_awaddr;
wire [7:0]  s_axi_awlen;
wire [2:0]  s_axi_awsize;
wire [1:0]  s_axi_awburst;
wire [1:0]  s_axi_awlock;
wire [3:0]  s_axi_awcache;
wire [2:0]  s_axi_awprot;
wire [3:0]  s_axi_awqos;
wire [4:0]  s_axi_awuser;
 
wire [2:0]  s_axi_wid;
wire        s_axi_wvalid;
wire         s_axi_wready;
wire [31:0] s_axi_wdata;
wire [3:0]  s_axi_wstrb;
wire        s_axi_wlast;

wire  [2:0]  s_axi_bid;
wire         s_axi_bvalid;
wire        s_axi_bready;
wire  [1:0]  s_axi_bresp;

wire [2:0]  s_axi_arid;
wire        s_axi_arvalid;
wire         s_axi_arready;
wire [23:0] s_axi_araddr;
wire [7:0]  s_axi_arlen;
wire [2:0]  s_axi_arsize;
wire [1:0]  s_axi_arburst;
wire [1:0]  s_axi_arlock;
wire [3:0]  s_axi_arcache;
wire [2:0]  s_axi_arprot;
wire [3:0]  s_axi_arqos;
wire [4:0]  s_axi_aruser;

wire  [2:0] s_axi_rid;
wire        s_axi_rvalid;
wire        s_axi_rready;
wire  [31:0]s_axi_rdata;
wire        s_axi_rlast;
wire  [1:0] s_axi_rresp;

reg        write;
reg [23:0] write_address;
reg [7:0]  write_burstlen;
reg [31:0]  write_data;
reg        read;
reg [23:0] read_address;
reg [7:0]  read_burstlen;
wire [31:0] read_data;

axi4_slave slave (
  .s_axi_aclk	(s_axi_aclk),
  .s_axi_aresetn	(s_axi_aresetn),
  .s_axi_awid  	(s_axi_awid),
  .s_axi_awvalid	(s_axi_awvalid),
  .s_axi_awready	(s_axi_awready),
  .s_axi_awaddr	(s_axi_awaddr),
  .s_axi_awlen	(s_axi_awlen),
  .s_axi_awsize  (s_axi_awsize),
  .s_axi_awburst (s_axi_awburst),
  .s_axi_awlock	(s_axi_awlock),
  .s_axi_awcache	(s_axi_awcache),
  .s_axi_awprot	(s_axi_awprot),
  .s_axi_awqos	(s_axi_awqos),
  .s_axi_awuser	(s_axi_awuser),
  .s_axi_wid	    (s_axi_wid),
  .s_axi_wvalid	(s_axi_wvalid),
  .s_axi_wready	(s_axi_wready),
  .s_axi_wdata 	(s_axi_wdata),
  .s_axi_wstrb	(s_axi_wstrb),
  .s_axi_wlast	(s_axi_wlast),
  .s_axi_bid	    (s_axi_bid),
  .s_axi_bvalid	(s_axi_bvalid),
  .s_axi_bready	(s_axi_bready),
  .s_axi_bresp 	(s_axi_bresp),
  .s_axi_arid	(s_axi_arid),
  .s_axi_arvalid	(s_axi_arvalid),
  .s_axi_arready	(s_axi_arready),
  .s_axi_araddr	(s_axi_araddr),
  .s_axi_arlen	(s_axi_arlen),
  .s_axi_arsize	(s_axi_arsize),
  .s_axi_arburst	(s_axi_arburst),
  .s_axi_arlock	(s_axi_arlock),
  .s_axi_arcache	(s_axi_arcache),
  .s_axi_arprot	(s_axi_arprot),
  .s_axi_arqos	(s_axi_arqos),
  .s_axi_aruser	(s_axi_aruser),
  .s_axi_rid	    (s_axi_rid),
  .s_axi_rvalid	(s_axi_rvalid),
  .s_axi_rready	(s_axi_rready),
  .s_axi_rdata 	(s_axi_rdata),
  .s_axi_rlast	(s_axi_rlast),
  .s_axi_rresp 	(s_axi_rresp));

axi4_master master ( 
  .m_axi_aclk	(s_axi_aclk),
  .m_axi_aresetn	(s_axi_aresetn),
  .m_axi_awid  	(s_axi_awid),
  .m_axi_awvalid	(s_axi_awvalid),
  .m_axi_awready	(s_axi_awready),
  .m_axi_awaddr	(s_axi_awaddr),
  .m_axi_awlen	(s_axi_awlen),
  .m_axi_awsize  (s_axi_awsize),
  .m_axi_awburst (s_axi_awburst),
  .m_axi_awlock	(s_axi_awlock),
  .m_axi_awcache	(s_axi_awcache),
  .m_axi_awprot	(s_axi_awprot),
  .m_axi_awqos	(s_axi_awqos),
  .m_axi_awuser	(s_axi_awuser),
  .m_axi_wid	    (s_axi_wid),
  .m_axi_wvalid	(s_axi_wvalid),
  .m_axi_wready	(s_axi_wready),
  .m_axi_wdata 	(s_axi_wdata),
  .m_axi_wstrb	(s_axi_wstrb),
  .m_axi_wlast	(s_axi_wlast),
  .m_axi_bid	    (s_axi_bid),
  .m_axi_bvalid	(s_axi_bvalid),
  .m_axi_bready	(s_axi_bready),
  .m_axi_bresp 	(s_axi_bresp),
  .m_axi_arid	(s_axi_arid),
  .m_axi_arvalid	(s_axi_arvalid),
  .m_axi_arready	(s_axi_arready),
  .m_axi_araddr	(s_axi_araddr),
  .m_axi_arlen	(s_axi_arlen),
  .m_axi_arsize	(s_axi_arsize),
  .m_axi_arburst	(s_axi_arburst),
  .m_axi_arlock	(s_axi_arlock),
  .m_axi_arcache	(s_axi_arcache),
  .m_axi_arprot	(s_axi_arprot),
  .m_axi_arqos	(s_axi_arqos),
  .m_axi_aruser	(s_axi_aruser),
  .m_axi_rid	    (s_axi_rid),
  .m_axi_rvalid	(s_axi_rvalid),
  .m_axi_rready	(s_axi_rready),
  .m_axi_rdata 	(s_axi_rdata),
  .m_axi_rlast	(s_axi_rlast),
  .m_axi_rresp 	(s_axi_rresp),
  .write(write),
  .write_address(write_address),
  .write_burstlen(write_burstlen),
  .write_data(write_data),
  .read(read),
  .read_address(read_address),
  .read_burstlen(read_burstlen),
  .read_data(read_data));

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