//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (lin64) Build 2552052 Fri May 24 14:47:09 MDT 2019
//Date        : Sun May 26 16:16:21 2024
//Host        : developer-Alienware-17-R5 running 64-bit Ubuntu 22.04.4 LTS
//Command     : generate_target axi4_block.bd
//Design      : axi4_block
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "axi4_block,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=axi4_block,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=3,numReposBlks=3,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=2,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "axi4_block.hwdef" *) 
module axi4_block
   (m_axi_aclk_0,
    m_axi_aresetn_0,
    read_0,
    read_address_0,
    read_burstlen_0,
    read_data_0,
    write_0,
    write_address_0,
    write_burstlen_0,
    write_data_0);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.M_AXI_ACLK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.M_AXI_ACLK_0, ASSOCIATED_RESET m_axi_aresetn_0, CLK_DOMAIN axi4_block_m_axi_aclk_0, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000" *) input m_axi_aclk_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.M_AXI_ARESETN_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.M_AXI_ARESETN_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input m_axi_aresetn_0;
  input read_0;
  input [23:0]read_address_0;
  input [7:0]read_burstlen_0;
  output [31:0]read_data_0;
  input write_0;
  input [23:0]write_address_0;
  input [7:0]write_burstlen_0;
  input [31:0]write_data_0;

  wire [23:0]axi4_master_0_m_axi_ARADDR;
  wire [1:0]axi4_master_0_m_axi_ARBURST;
  wire [3:0]axi4_master_0_m_axi_ARCACHE;
  wire [2:0]axi4_master_0_m_axi_ARID;
  wire [7:0]axi4_master_0_m_axi_ARLEN;
  wire [1:0]axi4_master_0_m_axi_ARLOCK;
  wire [2:0]axi4_master_0_m_axi_ARPROT;
  wire [3:0]axi4_master_0_m_axi_ARQOS;
  wire axi4_master_0_m_axi_ARREADY;
  wire [2:0]axi4_master_0_m_axi_ARSIZE;
  wire [4:0]axi4_master_0_m_axi_ARUSER;
  wire axi4_master_0_m_axi_ARVALID;
  wire [23:0]axi4_master_0_m_axi_AWADDR;
  wire [1:0]axi4_master_0_m_axi_AWBURST;
  wire [3:0]axi4_master_0_m_axi_AWCACHE;
  wire [2:0]axi4_master_0_m_axi_AWID;
  wire [7:0]axi4_master_0_m_axi_AWLEN;
  wire [1:0]axi4_master_0_m_axi_AWLOCK;
  wire [2:0]axi4_master_0_m_axi_AWPROT;
  wire [3:0]axi4_master_0_m_axi_AWQOS;
  wire axi4_master_0_m_axi_AWREADY;
  wire [2:0]axi4_master_0_m_axi_AWSIZE;
  wire [4:0]axi4_master_0_m_axi_AWUSER;
  wire axi4_master_0_m_axi_AWVALID;
  wire [2:0]axi4_master_0_m_axi_BID;
  wire axi4_master_0_m_axi_BREADY;
  wire [1:0]axi4_master_0_m_axi_BRESP;
  wire axi4_master_0_m_axi_BVALID;
  wire [31:0]axi4_master_0_m_axi_RDATA;
  wire [2:0]axi4_master_0_m_axi_RID;
  wire axi4_master_0_m_axi_RLAST;
  wire axi4_master_0_m_axi_RREADY;
  wire [1:0]axi4_master_0_m_axi_RRESP;
  wire axi4_master_0_m_axi_RVALID;
  wire [31:0]axi4_master_0_m_axi_WDATA;
  wire [2:0]axi4_master_0_m_axi_WID;
  wire axi4_master_0_m_axi_WLAST;
  wire axi4_master_0_m_axi_WREADY;
  wire [3:0]axi4_master_0_m_axi_WSTRB;
  wire axi4_master_0_m_axi_WVALID;
  wire [31:0]axi4_master_0_read_data;
  wire m_axi_aclk_0_1;
  wire m_axi_aresetn_0_1;
  wire read_0_1;
  wire [23:0]read_address_0_1;
  wire [7:0]read_burstlen_0_1;
  wire write_0_1;
  wire [23:0]write_address_0_1;
  wire [7:0]write_burstlen_0_1;
  wire [31:0]write_data_0_1;

  assign m_axi_aclk_0_1 = m_axi_aclk_0;
  assign m_axi_aresetn_0_1 = m_axi_aresetn_0;
  assign read_0_1 = read_0;
  assign read_address_0_1 = read_address_0[23:0];
  assign read_burstlen_0_1 = read_burstlen_0[7:0];
  assign read_data_0[31:0] = axi4_master_0_read_data;
  assign write_0_1 = write_0;
  assign write_address_0_1 = write_address_0[23:0];
  assign write_burstlen_0_1 = write_burstlen_0[7:0];
  assign write_data_0_1 = write_data_0[31:0];
  axi4_block_axi4_master_0_0 axi4_master_0
       (.m_axi_aclk(m_axi_aclk_0_1),
        .m_axi_araddr(axi4_master_0_m_axi_ARADDR),
        .m_axi_arburst(axi4_master_0_m_axi_ARBURST),
        .m_axi_arcache(axi4_master_0_m_axi_ARCACHE),
        .m_axi_aresetn(m_axi_aresetn_0_1),
        .m_axi_arid(axi4_master_0_m_axi_ARID),
        .m_axi_arlen(axi4_master_0_m_axi_ARLEN),
        .m_axi_arlock(axi4_master_0_m_axi_ARLOCK),
        .m_axi_arprot(axi4_master_0_m_axi_ARPROT),
        .m_axi_arqos(axi4_master_0_m_axi_ARQOS),
        .m_axi_arready(axi4_master_0_m_axi_ARREADY),
        .m_axi_arsize(axi4_master_0_m_axi_ARSIZE),
        .m_axi_aruser(axi4_master_0_m_axi_ARUSER),
        .m_axi_arvalid(axi4_master_0_m_axi_ARVALID),
        .m_axi_awaddr(axi4_master_0_m_axi_AWADDR),
        .m_axi_awburst(axi4_master_0_m_axi_AWBURST),
        .m_axi_awcache(axi4_master_0_m_axi_AWCACHE),
        .m_axi_awid(axi4_master_0_m_axi_AWID),
        .m_axi_awlen(axi4_master_0_m_axi_AWLEN),
        .m_axi_awlock(axi4_master_0_m_axi_AWLOCK),
        .m_axi_awprot(axi4_master_0_m_axi_AWPROT),
        .m_axi_awqos(axi4_master_0_m_axi_AWQOS),
        .m_axi_awready(axi4_master_0_m_axi_AWREADY),
        .m_axi_awsize(axi4_master_0_m_axi_AWSIZE),
        .m_axi_awuser(axi4_master_0_m_axi_AWUSER),
        .m_axi_awvalid(axi4_master_0_m_axi_AWVALID),
        .m_axi_bid(axi4_master_0_m_axi_BID[0]),
        .m_axi_bready(axi4_master_0_m_axi_BREADY),
        .m_axi_bresp(axi4_master_0_m_axi_BRESP[0]),
        .m_axi_bvalid(axi4_master_0_m_axi_BVALID),
        .m_axi_rdata(axi4_master_0_m_axi_RDATA),
        .m_axi_rid(axi4_master_0_m_axi_RID),
        .m_axi_rlast(axi4_master_0_m_axi_RLAST),
        .m_axi_rready(axi4_master_0_m_axi_RREADY),
        .m_axi_rresp(axi4_master_0_m_axi_RRESP),
        .m_axi_rvalid(axi4_master_0_m_axi_RVALID),
        .m_axi_wdata(axi4_master_0_m_axi_WDATA),
        .m_axi_wid(axi4_master_0_m_axi_WID),
        .m_axi_wlast(axi4_master_0_m_axi_WLAST),
        .m_axi_wready(axi4_master_0_m_axi_WREADY),
        .m_axi_wstrb(axi4_master_0_m_axi_WSTRB),
        .m_axi_wvalid(axi4_master_0_m_axi_WVALID),
        .read(read_0_1),
        .read_address(read_address_0_1),
        .read_burstlen(read_burstlen_0_1),
        .read_data(axi4_master_0_read_data),
        .write(write_0_1),
        .write_address(write_address_0_1),
        .write_burstlen(write_burstlen_0_1),
        .write_data(write_data_0_1));
  axi4_block_axi4_slave_0_0 axi4_slave_0
       (.s_axi_aclk(m_axi_aclk_0_1),
        .s_axi_araddr(axi4_master_0_m_axi_ARADDR),
        .s_axi_arburst(axi4_master_0_m_axi_ARBURST),
        .s_axi_arcache(axi4_master_0_m_axi_ARCACHE),
        .s_axi_aresetn(m_axi_aresetn_0_1),
        .s_axi_arid(axi4_master_0_m_axi_ARID),
        .s_axi_arlen(axi4_master_0_m_axi_ARLEN),
        .s_axi_arlock(axi4_master_0_m_axi_ARLOCK),
        .s_axi_arprot(axi4_master_0_m_axi_ARPROT),
        .s_axi_arqos(axi4_master_0_m_axi_ARQOS),
        .s_axi_arready(axi4_master_0_m_axi_ARREADY),
        .s_axi_arsize(axi4_master_0_m_axi_ARSIZE),
        .s_axi_aruser(axi4_master_0_m_axi_ARUSER),
        .s_axi_arvalid(axi4_master_0_m_axi_ARVALID),
        .s_axi_awaddr(axi4_master_0_m_axi_AWADDR),
        .s_axi_awburst(axi4_master_0_m_axi_AWBURST),
        .s_axi_awcache(axi4_master_0_m_axi_AWCACHE),
        .s_axi_awid(axi4_master_0_m_axi_AWID),
        .s_axi_awlen(axi4_master_0_m_axi_AWLEN),
        .s_axi_awlock(axi4_master_0_m_axi_AWLOCK),
        .s_axi_awprot(axi4_master_0_m_axi_AWPROT),
        .s_axi_awqos(axi4_master_0_m_axi_AWQOS),
        .s_axi_awready(axi4_master_0_m_axi_AWREADY),
        .s_axi_awsize(axi4_master_0_m_axi_AWSIZE),
        .s_axi_awuser(axi4_master_0_m_axi_AWUSER),
        .s_axi_awvalid(axi4_master_0_m_axi_AWVALID),
        .s_axi_bid(axi4_master_0_m_axi_BID),
        .s_axi_bready(axi4_master_0_m_axi_BREADY),
        .s_axi_bresp(axi4_master_0_m_axi_BRESP),
        .s_axi_bvalid(axi4_master_0_m_axi_BVALID),
        .s_axi_rdata(axi4_master_0_m_axi_RDATA),
        .s_axi_rid(axi4_master_0_m_axi_RID),
        .s_axi_rlast(axi4_master_0_m_axi_RLAST),
        .s_axi_rready(axi4_master_0_m_axi_RREADY),
        .s_axi_rresp(axi4_master_0_m_axi_RRESP),
        .s_axi_rvalid(axi4_master_0_m_axi_RVALID),
        .s_axi_wdata(axi4_master_0_m_axi_WDATA),
        .s_axi_wid(axi4_master_0_m_axi_WID),
        .s_axi_wlast(axi4_master_0_m_axi_WLAST),
        .s_axi_wready(axi4_master_0_m_axi_WREADY),
        .s_axi_wstrb(axi4_master_0_m_axi_WSTRB),
        .s_axi_wvalid(axi4_master_0_m_axi_WVALID));
  axi4_block_axi_protocol_checker_0_0 axi_protocol_checker_0
       (.aclk(m_axi_aclk_0_1),
        .aresetn(m_axi_aresetn_0_1),
        .pc_axi_araddr(axi4_master_0_m_axi_ARADDR),
        .pc_axi_arburst(axi4_master_0_m_axi_ARBURST),
        .pc_axi_arcache(axi4_master_0_m_axi_ARCACHE),
        .pc_axi_arid(axi4_master_0_m_axi_ARID[0]),
        .pc_axi_arlen(axi4_master_0_m_axi_ARLEN),
        .pc_axi_arlock(axi4_master_0_m_axi_ARLOCK[0]),
        .pc_axi_arprot(axi4_master_0_m_axi_ARPROT),
        .pc_axi_arqos(axi4_master_0_m_axi_ARQOS),
        .pc_axi_arready(axi4_master_0_m_axi_ARREADY),
        .pc_axi_arregion({1'b0,1'b0,1'b0,1'b0}),
        .pc_axi_arsize(axi4_master_0_m_axi_ARSIZE),
        .pc_axi_aruser(axi4_master_0_m_axi_ARUSER),
        .pc_axi_arvalid(axi4_master_0_m_axi_ARVALID),
        .pc_axi_awaddr(axi4_master_0_m_axi_AWADDR),
        .pc_axi_awburst(axi4_master_0_m_axi_AWBURST),
        .pc_axi_awcache(axi4_master_0_m_axi_AWCACHE),
        .pc_axi_awid(axi4_master_0_m_axi_AWID[0]),
        .pc_axi_awlen(axi4_master_0_m_axi_AWLEN),
        .pc_axi_awlock(axi4_master_0_m_axi_AWLOCK[0]),
        .pc_axi_awprot(axi4_master_0_m_axi_AWPROT),
        .pc_axi_awqos(axi4_master_0_m_axi_AWQOS),
        .pc_axi_awready(axi4_master_0_m_axi_AWREADY),
        .pc_axi_awregion({1'b0,1'b0,1'b0,1'b0}),
        .pc_axi_awsize(axi4_master_0_m_axi_AWSIZE),
        .pc_axi_awuser(axi4_master_0_m_axi_AWUSER),
        .pc_axi_awvalid(axi4_master_0_m_axi_AWVALID),
        .pc_axi_bid(axi4_master_0_m_axi_BID[0]),
        .pc_axi_bready(axi4_master_0_m_axi_BREADY),
        .pc_axi_bresp(axi4_master_0_m_axi_BRESP),
        .pc_axi_bvalid(axi4_master_0_m_axi_BVALID),
        .pc_axi_rdata(axi4_master_0_m_axi_RDATA),
        .pc_axi_rid(axi4_master_0_m_axi_RID[0]),
        .pc_axi_rlast(axi4_master_0_m_axi_RLAST),
        .pc_axi_rready(axi4_master_0_m_axi_RREADY),
        .pc_axi_rresp(axi4_master_0_m_axi_RRESP),
        .pc_axi_rvalid(axi4_master_0_m_axi_RVALID),
        .pc_axi_wdata(axi4_master_0_m_axi_WDATA),
        .pc_axi_wlast(axi4_master_0_m_axi_WLAST),
        .pc_axi_wready(axi4_master_0_m_axi_WREADY),
        .pc_axi_wstrb(axi4_master_0_m_axi_WSTRB),
        .pc_axi_wvalid(axi4_master_0_m_axi_WVALID));
endmodule
