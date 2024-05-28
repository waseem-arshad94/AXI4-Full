//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (lin64) Build 2552052 Fri May 24 14:47:09 MDT 2019
//Date        : Sat May 25 13:00:21 2024
//Host        : developer-Alienware-17-R5 running 64-bit Ubuntu 22.04.4 LTS
//Command     : generate_target axi4_bd_wrapper.bd
//Design      : axi4_bd_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module axi4_bd_wrapper
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
  input m_axi_aclk_0;
  input m_axi_aresetn_0;
  input read_0;
  input [23:0]read_address_0;
  input [7:0]read_burstlen_0;
  output [31:0]read_data_0;
  input write_0;
  input [23:0]write_address_0;
  input [7:0]write_burstlen_0;
  input [31:0]write_data_0;

  wire m_axi_aclk_0;
  wire m_axi_aresetn_0;
  wire read_0;
  wire [23:0]read_address_0;
  wire [7:0]read_burstlen_0;
  wire [31:0]read_data_0;
  wire write_0;
  wire [23:0]write_address_0;
  wire [7:0]write_burstlen_0;
  wire [31:0]write_data_0;

  axi4_bd axi4_bd_i
       (.m_axi_aclk_0(m_axi_aclk_0),
        .m_axi_aresetn_0(m_axi_aresetn_0),
        .read_0(read_0),
        .read_address_0(read_address_0),
        .read_burstlen_0(read_burstlen_0),
        .read_data_0(read_data_0),
        .write_0(write_0),
        .write_address_0(write_address_0),
        .write_burstlen_0(write_burstlen_0),
        .write_data_0(write_data_0));
endmodule
