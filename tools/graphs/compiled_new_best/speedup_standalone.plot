set terminal postscript eps color size 3, 2.4
# use the following for terminal latex
#set format "$%g$"
set format "%g"
set datafile separator ","

set key below right

set xlabel "Kernanzahl"
set ylabel "Speedup"

set xrange [0:122]
set xtics 24
set key autotitle columnhead
set key box

set grid xtics lc rgb "#888888"
set grid ytics lc rgb "#888888"
set grid

set output "speedup_lenses_standalone.eps"
set title "Speedup mit steigender Kernanzahl\n {/*0.75 Lenses}"
set bmargin 7.7
plot "speedup_mpi.csv" using 1:6 with linespoints dashtype 3 pointtype 5 lw 3 lc 1 t "{/Times:Italic compiled} - Set 1 (10 Bildpaare)", \
	 "speedup_mpi.csv" using 1:7 with linespoints dashtype 3 pointtype 7 lw 3 lc 2 t "{/Times:Italic compiled} - Set 2 (5 Bildpaare)", \
	 "speedup_mpi.csv" using 1:8 with linespoints dashtype 3 pointtype 9 lw 3 lc 3 t "{/Times:Italic compiled} - Set 3 (1 Bildpaar)", \
	 "speedup_mpi.csv" using 1:9 with linespoints dashtype 3 pointtype 11 lw 3 lc 4 t "{/Times:Italic compiled} - Set 3 (2 Bildpaare)"
set output "speedup_exp6_standalone.eps"
set title "Speedup mit steigender Kernanzahl\n {/*0.75 Experiment 6}"
set bmargin 6.7
plot "speedup_mpi.csv" using 1:3 with linespoints dashtype 3 pointtype 5 lw 3 lc 1 t "{/Times:Italic compiled} - Lenses 200 (21 Bildpaare)", \
	 "speedup_mpi.csv" using 1:4 with linespoints dashtype 3 pointtype 7 lw 3 lc 2 t "{/Times:Italic compiled} - Lenses 500 (11 Bildpaare)", \
	 "speedup_mpi.csv" using 1:5 with linespoints dashtype 3 pointtype 9 lw 3 lc 3 t "{/Times:Italic compiled} - Lenses 1500 (14 Bildpaare)"
