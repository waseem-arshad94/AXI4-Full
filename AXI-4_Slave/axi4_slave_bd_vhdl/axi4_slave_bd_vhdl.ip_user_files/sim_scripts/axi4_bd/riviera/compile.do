vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../../axi4_slave_bd_vhdl.srcs/sources_1/bd/axi4_bd/sim/axi4_bd.v" \


vlog -work xil_defaultlib \
"glbl.v"
