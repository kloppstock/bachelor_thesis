set terminal postscript eps color size 2.55, 2.55 font "Times,13"
# use the following for terminal latex
#set format "$%g$"
set format "%g"
set datafile separator ","

set key below right

set xlabel "Kernanzahl"
set ylabel "Gesamtzeit (in Sekunden)"

set xrange [0:122]
set yrange [90:22000]
set ytics add ("20000" 20000)
set xtics 24
set logscale y
#set xrange[1:24]
set key autotitle columnhead
set key box

set grid xtics lc rgb "#888888"
set grid ytics lc rgb "#888888"
set grid

set output "times_lenses.eps"
set title "Laufzeit mit steigender Kernanzahl\n {/*0.75 Lenses}"
set bmargin 11.7
plot "total_time.csv" using 1:6 with linespoints dashtype 3 pointtype 4 lw 1 lc 1 t "Referenz - Set 1 (10 Bildpaare)", \
	 "total_time.csv" using 1:7 with linespoints dashtype 3 pointtype 6 lw 1 lc 2 t "Referenz - Set 2 (5 Bildpaare)", \
	 "total_time.csv" using 1:8 with linespoints dashtype 3 pointtype 8 lw 1 lc 3 t "Referenz - Set 3 (1 Bildpaar)", \
	 "total_time.csv" using 1:9 with linespoints dashtype 3 pointtype 10 lw 1 lc 4 t "Referenz - Set 3 (2 Bildpaare)", \
	"total_time_mpi.csv" using 1:6 with linespoints dashtype 3 pointtype 5 lw 3 lc 1 t "{/Times:Italic compiled} - Set 1 (10 Bildpaare)", \
	 "total_time_mpi.csv" using 1:7 with linespoints dashtype 3 pointtype 7 lw 3 lc 2 t "{/Times:Italic compiled} - Set 2 (5 Bildpaare)", \
	 "total_time_mpi.csv" using 1:8 with linespoints dashtype 3 pointtype 9 lw 3 lc 3 t "{/Times:Italic compiled} - Set 3 (1 Bildpaar)", \
	 "total_time_mpi.csv" using 1:9 with linespoints dashtype 3 pointtype 11 lw 3 lc 4 t "{/Times:Italic compiled} - Set 3 (2 Bildpaare)"
set yrange [27:22000]
set ytics auto
set ytics add ("30" 30) ("20000" 20000)
set output "times_exp6.eps"
set title "Laufzeit mit steigender Kernanzahl\n {/*0.75 Experiment 6}"
set bmargin 9.7
plot "total_time.csv" using 1:3 with linespoints dashtype 3 pointtype 4 lw 1 t "Referenz - Lenses 200 (21 Bildpaare)", \
	 "total_time.csv" using 1:4 with linespoints dashtype 3 pointtype 6 lw 1 t "Referenz - Lenses 500 (11 Bildpaare)", \
	 "total_time.csv" using 1:5 with linespoints dashtype 3 pointtype 8 lw 1 t "Referenz - Lenses 1500 (14 Bildpaare)", \
	"total_time_mpi.csv" using 1:3 with linespoints dashtype 3 pointtype 5 lw 3 lc 1 t "{/Times:Italic compiled} - Lenses 200 (21 Bildpaare)", \
	 "total_time_mpi.csv" using 1:4 with linespoints dashtype 3 pointtype 7 lw 3 lc 2 t "{/Times:Italic compiled} - Lenses 500 (11 Bildpaare)", \
	 "total_time_mpi.csv" using 1:5 with linespoints dashtype 3 pointtype 9 lw 3 lc 3 t "{/Times:Italic compiled} - Lenses 1500 (14 Bildpaare)"
