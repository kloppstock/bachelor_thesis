set terminal postscript eps color size 2.55, 2.55 font "Times,13"
# use the following for terminal latex
#set format "$%g$"
set format "%g"
set datafile separator ","

set key below right

set logscale y
#set xrange[0:25]
set xrange [0:122]
set yrange [18:2200]
set ytics add ("20" 20) ("2000" 2000)
set xtics 24
set xlabel "Kernanzahl"
set ylabel "Rundenzeit (in Sekunden)"

set key autotitle columnhead
set key box

set grid xtics lc rgb "#888888"
set grid ytics lc rgb "#888888"
set grid

set output "round_times_lenses.eps"
set title "Rundenzeit mit steigender Kernanzahl\n {/*0.75 Lenses}"
set bmargin 11.7
set key width 0
plot "round_time.csv" using 1:6 with linespoints dashtype 3 pointtype 4 lw 1 t "Referenz - Set 1 (10 Bildpaare)", \
	 "round_time.csv" using 1:7 with linespoints dashtype 3 pointtype 6 lw 1 t "Referenz - Set 2 (5 Bildpaare)", \
	 "round_time.csv" using 1:8 with linespoints dashtype 3 pointtype 8 lw 1 t "Referenz - Set 3 (1 Bildpaar)", \
	 "round_time.csv" using 1:9 with linespoints dashtype 3 pointtype 10 lw 1 t "Referenz - Set 3 (2 Bildpaare)", \
	"round_time_mpi.csv" using 1:6 with linespoints dashtype 3 pointtype 5 lw 3 lc 1 t "{/Times:Italic compiled} - Set 1 (10 Bildpaare)", \
	 "round_time_mpi.csv" using 1:7 with linespoints dashtype 3 pointtype 7 lw 3 lc 2 t "{/Times:Italic compiled} - Set 2 (5 Bildpaare)", \
	 "round_time_mpi.csv" using 1:8 with linespoints dashtype 3 pointtype 9 lw 3 lc 3 t "{/Times:Italic compiled} - Set 3 (1 Bildpaar)", \
	 "round_time_mpi.csv" using 1:9 with linespoints dashtype 3 pointtype 11 lw 3 lc 4 t "{/Times:Italic compiled} - Set 3 (2 Bildpaare)"

set yrange [1:1000]
set output "round_times_exp6.eps"
set title "Rundenzeit mit steigender Kernanzahl\n {/*0.75 Experiment 6}"
set bmargin 10.7
set yrange [2.7:1100]
set ytics auto
set ytics add ("3" 3)
plot "round_time.csv" using 1:3 with linespoints dashtype 3 pointtype 4 lw 1 t "Referenz - Lenses 200 (21 Bildpaare)", \
	 "round_time.csv" using 1:4 with linespoints dashtype 3 pointtype 6 lw 1 t "Referenz - Lenses 500 (11 Bildpaare)", \
	 "round_time.csv" using 1:5 with linespoints dashtype 3 pointtype 8 lw 1 t "Referenz - Lenses 1500 (14 Bildpaare)", \
	"round_time_mpi.csv" using 1:3 with linespoints dashtype 3 pointtype 5 lw 3 lc 1 t "{/Times:Italic compiled} - Lenses 200 (21 Bildpaare)", \
	 "round_time_mpi.csv" using 1:4 with linespoints dashtype 3 pointtype 7 lw 3 lc 2 t "{/Times:Italic compiled} - Lenses 500 (11 Bildpaare)", \
	 "round_time_mpi.csv" using 1:5 with linespoints dashtype 3 pointtype 9 lw 3 lc 3 t "{/Times:Italic compiled} - Lenses 1500 (14 Bildpaare)"
