set title "scaling efficiency of dgemm alg"
set nogrid
set key top right
set border 3
set xlabel "matrix dimension, N"
set ylabel "GF"
set logscale xy
set xtics nomirror 512,2,4096
set ytics nomirror
set term png size 500,500 enhanced
# to convert to GB/s:
# mutiply by 64 - cache block size
# divide by 10^9

set output "tmp"
plot [512:4096][] "eff.data" using 1:2 w lp lc "magenta" lw 1 ps 2 pt 13 t "naive"
replot "eff.data" using 1:3 w lp lc "red"   lw 1 ps 2 pt 11 t "avx256"
replot "eff.data" using 1:4 w lp lc "cyan"  lw 1 ps 2 pt 15 t "+ loop unroll"
replot "eff.data" using 1:5 w lp lc "blue"  lw 1 ps 2 pt  9 t "+ cache block"
set output "eff.png"
replot "eff.data" using 1:6 w lp lc "green" lw 1 ps 2 pt 17 t "+ omp"

sys "rm tmp"

# GF values, 8 omp threads
# N	mm	mmasm	mmasmlu	mmcb	mmomp
