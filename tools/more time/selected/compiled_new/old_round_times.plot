set terminal postscript eps color size 2.8, 2.8
# use the following for terminal latex
#set format "$%g$"
set format "%g"
set datafile separator ","

set key below right

set logscale y
#set xrange[1:24]
set xtics 24
set xlabel "Kernanzahl"
set ylabel "Rundenzeit (in Sekunden)"

set key autotitle columnhead
set key box

set grid xtics lc rgb "#888888"
set grid ytics lc rgb "#888888"
set grid

set output "round_times_lenses.eps"
set title "Kernanzahl vs. Rundenzeit\n {/*0.75 Lenses}"
set bmargin 11.7
set key width 0
plot "round_time.csv" using 1:6 with linespoints dashtype 3 pointtype 4 lw 1 t "Set 1 (10 Bildpaare)", \
	 "round_time.csv" using 1:7 with linespoints dashtype 3 pointtype 6 lw 1 t "Set 2 (5 Bildpaare)", \
	 "round_time.csv" using 1:8 with linespoints dashtype 3 pointtype 8 lw 1 t "Set 3 (1 Bildpaare)", \
	 "round_time.csv" using 1:9 with linespoints dashtype 3 pointtype 10 lw 1 t "Set 3 (2 Bildpaare)", \
	"round_time_mpi.csv" using 1:6 with linespoints dashtype 3 pointtype 5 lw 3 lc 1 t "Optimiert - Set 1 (10 Bildpaare)", \
	 "round_time_mpi.csv" using 1:7 with linespoints dashtype 3 pointtype 7 lw 3 lc 2 t "Optimiert - Set 2 (5 Bildpaare)", \
	 "round_time_mpi.csv" using 1:8 with linespoints dashtype 3 pointtype 9 lw 3 lc 3 t "Optimiert - Set 3 (1 Bildpaare)", \
	 "round_time_mpi.csv" using 1:9 with linespoints dashtype 3 pointtype 11 lw 3 lc 4 t "Optimiert - Set 3 (2 Bildpaare)"
set output "round_times_exp6.eps"
set title "Kernanzahl vs. Rundenzeit\n {/*0.75 Experiment 6}"
set bmargin 10.7
plot "round_time.csv" using 1:3 with linespoints dashtype 3 pointtype 4 lw 1 t "Lenses 200 (21 Bildpaare)", \
	 "round_time.csv" using 1:4 with linespoints dashtype 3 pointtype 6 lw 1 t "Lenses 500 (11 Bildpaare)", \
	 "round_time.csv" using 1:5 with linespoints dashtype 3 pointtype 8 lw 1 t "Lenses 1500 (14 Bildpaare)", \
	"round_time_mpi.csv" using 1:3 with linespoints dashtype 3 pointtype 5 lw 3 lc 1 t "Optimiert - Lenses 200 (21 Bildpaare)", \
	 "round_time_mpi.csv" using 1:4 with linespoints dashtype 3 pointtype 7 lw 3 lc 2 t "Optimiert - Lenses 500 (11 Bildpaare)", \
	 "round_time_mpi.csv" using 1:5 with linespoints dashtype 3 pointtype 9 lw 3 lc 3 t "Optimiert - Lenses 1500 (14 Bildpaare)"
