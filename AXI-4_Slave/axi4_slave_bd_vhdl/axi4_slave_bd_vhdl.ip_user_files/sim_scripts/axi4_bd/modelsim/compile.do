vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr \
"../../../../axi4_slave_bd_vhdl.srcs/sources_1/bd/axi4_bd/sim/axi4_bd.v" \


vlog -work xil_defaultlib \
"glbl.v"

