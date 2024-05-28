//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (lin64) Build 2552052 Fri May 24 14:47:09 MDT 2019
//Date        : Fri May 24 19:00:35 2024
//Host        : developer-Alienware-17-R5 running 64-bit Ubuntu 22.04.4 LTS
//Command     : generate_target axi4_bd_wrapper.bd
//Design      : axi4_bd_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module axi4_bd_wrapper
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
  input M_AXI_ACLK_0;
  input M_AXI_ARESETN_0;
  input READ_0;
  input [23:0]READ_ADDRESS_0;
  input [7:0]READ_BURSTLEN_0;
  output [31:0]READ_DATA_0;
  input WRITE_0;
  input [23:0]WRITE_ADDRESS_0;
  input [7:0]WRITE_BURSTLEN_0;
  input [31:0]WRITE_DATA_0;

  wire M_AXI_ACLK_0;
  wire M_AXI_ARESETN_0;
  wire READ_0;
  wire [23:0]READ_ADDRESS_0;
  wire [7:0]READ_BURSTLEN_0;
  wire [31:0]READ_DATA_0;
  wire WRITE_0;
  wire [23:0]WRITE_ADDRESS_0;
  wire [7:0]WRITE_BURSTLEN_0;
  wire [31:0]WRITE_DATA_0;

  axi4_bd axi4_bd_i
       (.M_AXI_ACLK_0(M_AXI_ACLK_0),
        .M_AXI_ARESETN_0(M_AXI_ARESETN_0),
        .READ_0(READ_0),
        .READ_ADDRESS_0(READ_ADDRESS_0),
        .READ_BURSTLEN_0(READ_BURSTLEN_0),
        .READ_DATA_0(READ_DATA_0),
        .WRITE_0(WRITE_0),
        .WRITE_ADDRESS_0(WRITE_ADDRESS_0),
        .WRITE_BURSTLEN_0(WRITE_BURSTLEN_0),
        .WRITE_DATA_0(WRITE_DATA_0));
endmodule
