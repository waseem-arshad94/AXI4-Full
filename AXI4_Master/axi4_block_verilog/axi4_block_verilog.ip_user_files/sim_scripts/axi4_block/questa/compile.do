vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 \
"../../../../axi4_block_verilog.srcs/sources_1/bd/axi4_block/sim/axi4_block.v" \


vlog -work xil_defaultlib \
"glbl.v"

