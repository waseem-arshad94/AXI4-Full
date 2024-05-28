#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.1 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Sun May 26 16:04:30 PKT 2024
# SW Build 2552052 on Fri May 24 14:47:09 MDT 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xelab -wto ece58f57cb034cf7b90ec8eea9aab12e --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot t_axi4_master_behav xil_defaultlib.t_axi4_master xil_defaultlib.glbl -log elaborate.log"
xelab -wto ece58f57cb034cf7b90ec8eea9aab12e --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot t_axi4_master_behav xil_defaultlib.t_axi4_master xil_defaultlib.glbl -log elaborate.log

