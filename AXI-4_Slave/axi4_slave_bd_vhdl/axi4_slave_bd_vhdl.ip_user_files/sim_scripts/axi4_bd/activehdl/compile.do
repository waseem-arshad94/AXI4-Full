vlib work
vlib activehdl

vlib activehdl/xil_defaultlib

vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../../axi4_slave_bd_vhdl.srcs/sources_1/bd/axi4_bd/sim/axi4_bd.v" \


vlog -work xil_defaultlib \
"glbl.v"

