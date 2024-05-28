//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (lin64) Build 2552052 Fri May 24 14:47:09 MDT 2019
//Date        : Fri May 24 19:00:35 2024
//Host        : developer-Alienware-17-R5 running 64-bit Ubuntu 22.04.4 LTS
//Command     : generate_target axi4_bd.bd
//Design      : axi4_bd
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "axi4_bd,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=axi4_bd,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=3,numReposBlks=3,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=2,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "axi4_bd.hwdef" *) 
module axi4_bd
   (M_AXI_ACLK_0,
    M_AXI_ARESETN_0,
    READ_0,
    READ_ADDRESS_0,
    READ_BURSTLEN_0,
    READ_DATA_0,
    WRITE_0,
    WRITE_ADDRESS_0,
    WRITE_BURSTLEN_0,
    WRITE_DATA_0);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.M_AXI_ACLK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.M_AXI_ACLK_0, ASSOCIATED_RESET M_AXI_ARESETN_0, CLK_DOMAIN axi4_bd_M_AXI_ACLK_0, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000" *) input M_AXI_ACLK_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.M_AXI_ARESETN_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.M_AXI_ARESETN_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input M_AXI_ARESETN_0;
  input READ_0;
  input [23:0]READ_ADDRESS_0;
  input [7:0]READ_BURSTLEN_0;
  output [31:0]READ_DATA_0;
  input WRITE_0;
  input [23:0]WRITE_ADDRESS_0;
  input [7:0]WRITE_BURSTLEN_0;
  input [31:0]WRITE_DATA_0;

  wire [23:0]AXI4_MASTER_0_M_AXI_ARADDR;
  wire [1:0]AXI4_MASTER_0_M_AXI_ARBURST;
  wire [3:0]AXI4_MASTER_0_M_AXI_ARCACHE;
  wire [2:0]AXI4_MASTER_0_M_AXI_ARID;
  wire [7:0]AXI4_MASTER_0_M_AXI_ARLEN;
  wire [1:0]AXI4_MASTER_0_M_AXI_ARLOCK;
  wire [2:0]AXI4_MASTER_0_M_AXI_ARPROT;
  wire [3:0]AXI4_MASTER_0_M_AXI_ARQOS;
  wire AXI4_MASTER_0_M_AXI_ARREADY;
  wire [2:0]AXI4_MASTER_0_M_AXI_ARSIZE;
  wire [4:0]AXI4_MASTER_0_M_AXI_ARUSER;
  wire AXI4_MASTER_0_M_AXI_ARVALID;
  wire [23:0]AXI4_MASTER_0_M_AXI_AWADDR;
  wire [1:0]AXI4_MASTER_0_M_AXI_AWBURST;
  wire [3:0]AXI4_MASTER_0_M_AXI_AWCACHE;
  wire [2:0]AXI4_MASTER_0_M_AXI_AWID;
  wire [7:0]AXI4_MASTER_0_M_AXI_AWLEN;
  wire [1:0]AXI4_MASTER_0_M_AXI_AWLOCK;
  wire [2:0]AXI4_MASTER_0_M_AXI_AWPROT;
  wire [3:0]AXI4_MASTER_0_M_AXI_AWQOS;
  wire AXI4_MASTER_0_M_AXI_AWREADY;
  wire [2:0]AXI4_MASTER_0_M_AXI_AWSIZE;
  wire [4:0]AXI4_MASTER_0_M_AXI_AWUSER;
  wire AXI4_MASTER_0_M_AXI_AWVALID;
  wire [2:0]AXI4_MASTER_0_M_AXI_BID;
  wire AXI4_MASTER_0_M_AXI_BREADY;
  wire [1:0]AXI4_MASTER_0_M_AXI_BRESP;
  wire AXI4_MASTER_0_M_AXI_BVALID;
  wire [31:0]AXI4_MASTER_0_M_AXI_RDATA;
  wire [2:0]AXI4_MASTER_0_M_AXI_RID;
  wire AXI4_MASTER_0_M_AXI_RLAST;
  wire AXI4_MASTER_0_M_AXI_RREADY;
  wire [1:0]AXI4_MASTER_0_M_AXI_RRESP;
  wire AXI4_MASTER_0_M_AXI_RVALID;
  wire [31:0]AXI4_MASTER_0_M_AXI_WDATA;
  wire [2:0]AXI4_MASTER_0_M_AXI_WID;
  wire AXI4_MASTER_0_M_AXI_WLAST;
  wire AXI4_MASTER_0_M_AXI_WREADY;
  wire [3:0]AXI4_MASTER_0_M_AXI_WSTRB;
  wire AXI4_MASTER_0_M_AXI_WVALID;
  wire [31:0]AXI4_MASTER_0_READ_DATA;
  wire M_AXI_ACLK_0_1;
  wire M_AXI_ARESETN_0_1;
  wire READ_0_1;
  wire [23:0]READ_ADDRESS_0_1;
  wire [7:0]READ_BURSTLEN_0_1;
  wire WRITE_0_1;
  wire [23:0]WRITE_ADDRESS_0_1;
  wire [7:0]WRITE_BURSTLEN_0_1;
  wire [31:0]WRITE_DATA_0_1;

  assign M_AXI_ACLK_0_1 = M_AXI_ACLK_0;
  assign M_AXI_ARESETN_0_1 = M_AXI_ARESETN_0;
  assign READ_0_1 = READ_0;
  assign READ_ADDRESS_0_1 = READ_ADDRESS_0[23:0];
  assign READ_BURSTLEN_0_1 = READ_BURSTLEN_0[7:0];
  assign READ_DATA_0[31:0] = AXI4_MASTER_0_READ_DATA;
  assign WRITE_0_1 = WRITE_0;
  assign WRITE_ADDRESS_0_1 = WRITE_ADDRESS_0[23:0];
  assign WRITE_BURSTLEN_0_1 = WRITE_BURSTLEN_0[7:0];
  assign WRITE_DATA_0_1 = WRITE_DATA_0[31:0];
  axi4_bd_AXI4_MASTER_0_0 AXI4_MASTER_0
       (.M_AXI_ACLK(M_AXI_ACLK_0_1),
        .M_AXI_ARADDR(AXI4_MASTER_0_M_AXI_ARADDR),
        .M_AXI_ARBURST(AXI4_MASTER_0_M_AXI_ARBURST),
        .M_AXI_ARCACHE(AXI4_MASTER_0_M_AXI_ARCACHE),
        .M_AXI_ARESETN(M_AXI_ARESETN_0_1),
        .M_AXI_ARID(AXI4_MASTER_0_M_AXI_ARID),
        .M_AXI_ARLEN(AXI4_MASTER_0_M_AXI_ARLEN),
        .M_AXI_ARLOCK(AXI4_MASTER_0_M_AXI_ARLOCK),
        .M_AXI_ARPROT(AXI4_MASTER_0_M_AXI_ARPROT),
        .M_AXI_ARQOS(AXI4_MASTER_0_M_AXI_ARQOS),
        .M_AXI_ARREADY(AXI4_MASTER_0_M_AXI_ARREADY),
        .M_AXI_ARSIZE(AXI4_MASTER_0_M_AXI_ARSIZE),
        .M_AXI_ARUSER(AXI4_MASTER_0_M_AXI_ARUSER),
        .M_AXI_ARVALID(AXI4_MASTER_0_M_AXI_ARVALID),
        .M_AXI_AWADDR(AXI4_MASTER_0_M_AXI_AWADDR),
        .M_AXI_AWBURST(AXI4_MASTER_0_M_AXI_AWBURST),
        .M_AXI_AWCACHE(AXI4_MASTER_0_M_AXI_AWCACHE),
        .M_AXI_AWID(AXI4_MASTER_0_M_AXI_AWID),
        .M_AXI_AWLEN(AXI4_MASTER_0_M_AXI_AWLEN),
        .M_AXI_AWLOCK(AXI4_MASTER_0_M_AXI_AWLOCK),
        .M_AXI_AWPROT(AXI4_MASTER_0_M_AXI_AWPROT),
        .M_AXI_AWQOS(AXI4_MASTER_0_M_AXI_AWQOS),
        .M_AXI_AWREADY(AXI4_MASTER_0_M_AXI_AWREADY),
        .M_AXI_AWSIZE(AXI4_MASTER_0_M_AXI_AWSIZE),
        .M_AXI_AWUSER(AXI4_MASTER_0_M_AXI_AWUSER),
        .M_AXI_AWVALID(AXI4_MASTER_0_M_AXI_AWVALID),
        .M_AXI_BID(AXI4_MASTER_0_M_AXI_BID),
        .M_AXI_BREADY(AXI4_MASTER_0_M_AXI_BREADY),
        .M_AXI_BRESP(AXI4_MASTER_0_M_AXI_BRESP),
        .M_AXI_BVALID(AXI4_MASTER_0_M_AXI_BVALID),
        .M_AXI_RDATA(AXI4_MASTER_0_M_AXI_RDATA),
        .M_AXI_RID(AXI4_MASTER_0_M_AXI_RID),
        .M_AXI_RLAST(AXI4_MASTER_0_M_AXI_RLAST),
        .M_AXI_RREADY(AXI4_MASTER_0_M_AXI_RREADY),
        .M_AXI_RRESP(AXI4_MASTER_0_M_AXI_RRESP),
        .M_AXI_RVALID(AXI4_MASTER_0_M_AXI_RVALID),
        .M_AXI_WDATA(AXI4_MASTER_0_M_AXI_WDATA),
        .M_AXI_WID(AXI4_MASTER_0_M_AXI_WID),
        .M_AXI_WLAST(AXI4_MASTER_0_M_AXI_WLAST),
        .M_AXI_WREADY(AXI4_MASTER_0_M_AXI_WREADY),
        .M_AXI_WSTRB(AXI4_MASTER_0_M_AXI_WSTRB),
        .M_AXI_WVALID(AXI4_MASTER_0_M_AXI_WVALID),
        .READ(READ_0_1),
        .READ_ADDRESS(READ_ADDRESS_0_1),
        .READ_BURSTLEN(READ_BURSTLEN_0_1),
        .READ_DATA(AXI4_MASTER_0_READ_DATA),
        .WRITE(WRITE_0_1),
        .WRITE_ADDRESS(WRITE_ADDRESS_0_1),
        .WRITE_BURSTLEN(WRITE_BURSTLEN_0_1),
        .WRITE_DATA(WRITE_DATA_0_1));
  axi4_bd_AXI4_SLAVE_0_0 AXI4_SLAVE_0
       (.S_AXI_ACLK(M_AXI_ACLK_0_1),
        .S_AXI_ARADDR(AXI4_MASTER_0_M_AXI_ARADDR),
        .S_AXI_ARBURST(AXI4_MASTER_0_M_AXI_ARBURST),
        .S_AXI_ARCACHE(AXI4_MASTER_0_M_AXI_ARCACHE),
        .S_AXI_ARESETN(M_AXI_ARESETN_0_1),
        .S_AXI_ARID(AXI4_MASTER_0_M_AXI_ARID),
        .S_AXI_ARLEN(AXI4_MASTER_0_M_AXI_ARLEN),
        .S_AXI_ARLOCK(AXI4_MASTER_0_M_AXI_ARLOCK),
        .S_AXI_ARPROT(AXI4_MASTER_0_M_AXI_ARPROT),
        .S_AXI_ARQOS(AXI4_MASTER_0_M_AXI_ARQOS),
        .S_AXI_ARREADY(AXI4_MASTER_0_M_AXI_ARREADY),
        .S_AXI_ARSIZE(AXI4_MASTER_0_M_AXI_ARSIZE),
        .S_AXI_ARUSER(AXI4_MASTER_0_M_AXI_ARUSER),
        .S_AXI_ARVALID(AXI4_MASTER_0_M_AXI_ARVALID),
        .S_AXI_AWADDR(AXI4_MASTER_0_M_AXI_AWADDR),
        .S_AXI_AWBURST(AXI4_MASTER_0_M_AXI_AWBURST),
        .S_AXI_AWCACHE(AXI4_MASTER_0_M_AXI_AWCACHE),
        .S_AXI_AWID(AXI4_MASTER_0_M_AXI_AWID),
        .S_AXI_AWLEN(AXI4_MASTER_0_M_AXI_AWLEN),
        .S_AXI_AWLOCK(AXI4_MASTER_0_M_AXI_AWLOCK),
        .S_AXI_AWPROT(AXI4_MASTER_0_M_AXI_AWPROT),
        .S_AXI_AWQOS(AXI4_MASTER_0_M_AXI_AWQOS),
        .S_AXI_AWREADY(AXI4_MASTER_0_M_AXI_AWREADY),
        .S_AXI_AWSIZE(AXI4_MASTER_0_M_AXI_AWSIZE),
        .S_AXI_AWUSER(AXI4_MASTER_0_M_AXI_AWUSER),
        .S_AXI_AWVALID(AXI4_MASTER_0_M_AXI_AWVALID),
        .S_AXI_BID(AXI4_MASTER_0_M_AXI_BID),
        .S_AXI_BREADY(AXI4_MASTER_0_M_AXI_BREADY),
        .S_AXI_BRESP(AXI4_MASTER_0_M_AXI_BRESP),
        .S_AXI_BVALID(AXI4_MASTER_0_M_AXI_BVALID),
        .S_AXI_RDATA(AXI4_MASTER_0_M_AXI_RDATA),
        .S_AXI_RID(AXI4_MASTER_0_M_AXI_RID),
        .S_AXI_RLAST(AXI4_MASTER_0_M_AXI_RLAST),
        .S_AXI_RREADY(AXI4_MASTER_0_M_AXI_RREADY),
        .S_AXI_RRESP(AXI4_MASTER_0_M_AXI_RRESP),
        .S_AXI_RVALID(AXI4_MASTER_0_M_AXI_RVALID),
        .S_AXI_WDATA(AXI4_MASTER_0_M_AXI_WDATA),
        .S_AXI_WID(AXI4_MASTER_0_M_AXI_WID),
        .S_AXI_WLAST(AXI4_MASTER_0_M_AXI_WLAST),
        .S_AXI_WREADY(AXI4_MASTER_0_M_AXI_WREADY),
        .S_AXI_WSTRB(AXI4_MASTER_0_M_AXI_WSTRB),
        .S_AXI_WVALID(AXI4_MASTER_0_M_AXI_WVALID));
  axi4_bd_axi_protocol_checker_0_0 axi_protocol_checker_0
       (.aclk(M_AXI_ACLK_0_1),
        .aresetn(M_AXI_ARESETN_0_1),
        .pc_axi_araddr(AXI4_MASTER_0_M_AXI_ARADDR),
        .pc_axi_arburst(AXI4_MASTER_0_M_AXI_ARBURST),
        .pc_axi_arcache(AXI4_MASTER_0_M_AXI_ARCACHE),
        .pc_axi_arid(AXI4_MASTER_0_M_AXI_ARID),
        .pc_axi_arlen(AXI4_MASTER_0_M_AXI_ARLEN),
        .pc_axi_arlock(AXI4_MASTER_0_M_AXI_ARLOCK[0]),
        .pc_axi_arprot(AXI4_MASTER_0_M_AXI_ARPROT),
        .pc_axi_arqos(AXI4_MASTER_0_M_AXI_ARQOS),
        .pc_axi_arready(AXI4_MASTER_0_M_AXI_ARREADY),
        .pc_axi_arregion({1'b0,1'b0,1'b0,1'b0}),
        .pc_axi_arsize(AXI4_MASTER_0_M_AXI_ARSIZE),
        .pc_axi_aruser(AXI4_MASTER_0_M_AXI_ARUSER),
        .pc_axi_arvalid(AXI4_MASTER_0_M_AXI_ARVALID),
        .pc_axi_awaddr(AXI4_MASTER_0_M_AXI_AWADDR),
        .pc_axi_awburst(AXI4_MASTER_0_M_AXI_AWBURST),
        .pc_axi_awcache(AXI4_MASTER_0_M_AXI_AWCACHE),
        .pc_axi_awid(AXI4_MASTER_0_M_AXI_AWID),
        .pc_axi_awlen(AXI4_MASTER_0_M_AXI_AWLEN),
        .pc_axi_awlock(AXI4_MASTER_0_M_AXI_AWLOCK[0]),
        .pc_axi_awprot(AXI4_MASTER_0_M_AXI_AWPROT),
        .pc_axi_awqos(AXI4_MASTER_0_M_AXI_AWQOS),
        .pc_axi_awready(AXI4_MASTER_0_M_AXI_AWREADY),
        .pc_axi_awregion({1'b0,1'b0,1'b0,1'b0}),
        .pc_axi_awsize(AXI4_MASTER_0_M_AXI_AWSIZE),
        .pc_axi_awuser(AXI4_MASTER_0_M_AXI_AWUSER),
        .pc_axi_awvalid(AXI4_MASTER_0_M_AXI_AWVALID),
        .pc_axi_bid(AXI4_MASTER_0_M_AXI_BID),
        .pc_axi_bready(AXI4_MASTER_0_M_AXI_BREADY),
        .pc_axi_bresp(AXI4_MASTER_0_M_AXI_BRESP),
        .pc_axi_bvalid(AXI4_MASTER_0_M_AXI_BVALID),
        .pc_axi_rdata(AXI4_MASTER_0_M_AXI_RDATA),
        .pc_axi_rid(AXI4_MASTER_0_M_AXI_RID),
        .pc_axi_rlast(AXI4_MASTER_0_M_AXI_RLAST),
        .pc_axi_rready(AXI4_MASTER_0_M_AXI_RREADY),
        .pc_axi_rresp(AXI4_MASTER_0_M_AXI_RRESP),
        .pc_axi_rvalid(AXI4_MASTER_0_M_AXI_RVALID),
        .pc_axi_wdata(AXI4_MASTER_0_M_AXI_WDATA),
        .pc_axi_wlast(AXI4_MASTER_0_M_AXI_WLAST),
        .pc_axi_wready(AXI4_MASTER_0_M_AXI_WREADY),
        .pc_axi_wstrb(AXI4_MASTER_0_M_AXI_WSTRB),
        .pc_axi_wvalid(AXI4_MASTER_0_M_AXI_WVALID));
endmodule