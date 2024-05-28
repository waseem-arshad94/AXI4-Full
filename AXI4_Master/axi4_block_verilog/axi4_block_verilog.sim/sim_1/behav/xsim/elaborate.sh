#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.1 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Sun May 26 16:16:27 PKT 2024
# SW Build 2552052 on Fri May 24 14:47:09 MDT 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xelab -wto 7628b83f4da546a081a4397239b9a465 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L smartconnect_v1_0 -L axi_protocol_checker_v2_0_5 -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot t_axi4_block_behav xil_defaultlib.t_axi4_block xil_defaultlib.glbl -log elaborate.log"
xelab -wto 7628b83f4da546a081a4397239b9a465 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L smartconnect_v1_0 -L axi_protocol_checker_v2_0_5 -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot t_axi4_block_behav xil_defaultlib.t_axi4_block xil_defaultlib.glbl -log elaborate.log

