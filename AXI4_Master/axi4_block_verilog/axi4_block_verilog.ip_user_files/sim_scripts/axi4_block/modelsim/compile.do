vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr \
"../../../../axi4_block_verilog.srcs/sources_1/bd/axi4_block/sim/axi4_block.v" \


vlog -work xil_defaultlib \
"glbl.v"

