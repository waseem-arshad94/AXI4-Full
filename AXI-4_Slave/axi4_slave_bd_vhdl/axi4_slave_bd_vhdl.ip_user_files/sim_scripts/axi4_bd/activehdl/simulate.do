onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+axi4_bd -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.axi4_bd xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {axi4_bd.udo}

run -all

endsim

quit -force
