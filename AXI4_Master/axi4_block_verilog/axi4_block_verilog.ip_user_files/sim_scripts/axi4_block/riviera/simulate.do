onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+axi4_block -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.axi4_block xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {axi4_block.udo}

run -all

endsim

quit -force
