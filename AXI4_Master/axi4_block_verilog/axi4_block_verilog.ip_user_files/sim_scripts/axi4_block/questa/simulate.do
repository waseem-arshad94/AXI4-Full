onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib axi4_block_opt

do {wave.do}

view wave
view structure
view signals

do {axi4_block.udo}

run -all

quit -force
