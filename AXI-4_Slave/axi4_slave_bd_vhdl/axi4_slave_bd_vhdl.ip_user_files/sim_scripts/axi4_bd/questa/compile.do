vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 \
"../../../../axi4_slave_bd_vhdl.srcs/sources_1/bd/axi4_bd/sim/axi4_bd.v" \


vlog -work xil_defaultlib \
"glbl.v"

