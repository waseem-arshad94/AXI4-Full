#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.1 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Sat May 25 13:00:31 PKT 2024
# SW Build 2552052 on Fri May 24 14:47:09 MDT 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xsim t_axi4_block_behav -key {Behavioral:sim_1:Functional:t_axi4_block} -tclbatch t_axi4_block.tcl -protoinst "protoinst_files/axi4_bd.protoinst" -log simulate.log"
xsim t_axi4_block_behav -key {Behavioral:sim_1:Functional:t_axi4_block} -tclbatch t_axi4_block.tcl -protoinst "protoinst_files/axi4_bd.protoinst" -log simulate.log

