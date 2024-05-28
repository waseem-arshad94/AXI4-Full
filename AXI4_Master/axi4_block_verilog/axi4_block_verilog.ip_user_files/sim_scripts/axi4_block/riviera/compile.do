vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../../axi4_block_verilog.srcs/sources_1/bd/axi4_block/sim/axi4_block.v" \


vlog -work xil_defaultlib \
"glbl.v"

