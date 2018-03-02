set terminal postscript eps color size 3, 3
# use the following for terminal latex
#set format "$%g$"
set format "%g"
set datafile separator ","

set key below right

set xlabel "Kernanzahl"
set ylabel "Speedup"

set xtics 24
set xrange [0:49]
set key autotitle columnhead
set key box

set grid xtics lc rgb "#888888"
set grid ytics lc rgb "#888888"
set grid

set output "mpi_speedup_lenses.eps"
set title "Speedup mit steigender Kernanzahl\n {/*0.75 Lenses}"
set bmargin 11.7
plot "speedup_mpi_base.csv" using 1:6 with linespoints dashtype 3 pointtype 4 lw 1 t "{/Times:Italic mpi} - Set 1 (10 Bildpaare)", \
	 "speedup_mpi_base.csv" using 1:7 with linespoints dashtype 3 pointtype 6 lw 1 t "{/Times:Italic mpi} - Set 2 (5 Bildpaare)", \
	 "speedup_mpi_base.csv" using 1:8 with linespoints dashtype 3 pointtype 8 lw 1 t "{/Times:Italic mpi} - Set 3 (1 Bildpaare)", \
	 "speedup_mpi_base.csv" using 1:9 with linespoints dashtype 3 pointtype 10 lw 1 t "{/Times:Italic mpi} - Set 3 (2 Bildpaare)", \
	"speedup_clean.csv" using 1:6 with linespoints dashtype 3 pointtype 5 lw 3 lc 1 t "{/Times:Italic mpi-advanced} - Set 1 (10 Bildpaare)", \
	 "speedup_clean.csv" using 1:7 with linespoints dashtype 3 pointtype 7 lw 3 lc 2 t "{/Times:Italic mpi-advanced} - Set 2 (5 Bildpaare)", \
	 "speedup_clean.csv" using 1:8 with linespoints dashtype 3 pointtype 9 lw 3 lc 3 t "{/Times:Italic mpi-advanced} - Set 3 (1 Bildpaare)", \
	 "speedup_clean.csv" using 1:9 with linespoints dashtype 3 pointtype 11 lw 3 lc 4 t "{/Times:Italic mpi-advanced} - Set 3 (2 Bildpaare)"


set output "mpi_speedup_exp6.eps"
set title "Speedup mit steigender Kernanzahl\n {/*0.75 Experiment 6}"
set bmargin 10.7
set yrange [5:31]
plot "speedup_mpi_base.csv" using 1:3 with linespoints dashtype 3 pointtype 4 lw 1 t "{/Times:Italic mpi} - Lenses 200 (21 Bildpaare)", \
	 "speedup_mpi_base.csv" using 1:4 with linespoints dashtype 3 pointtype 6 lw 1 t "{/Times:Italic mpi} - Lenses 500 (11 Bildpaare)", \
	 "speedup_mpi_base.csv" using 1:5 with linespoints dashtype 3 pointtype 8 lw 1 t "{/Times:Italic mpi} - Lenses 1500 (14 Bildpaare)", \
	"speedup_clean.csv" using 1:3 with linespoints dashtype 3 pointtype 5 lw 3 lc 1 t "{/Times:Italic mpi-advanced} - Lenses 200 (21 Bildpaare)", \
	 "speedup_clean.csv" using 1:4 with linespoints dashtype 3 pointtype 7 lw 3 lc 2 t "{/Times:Italic mpi-advanced} - Lenses 500 (11 Bildpaare)", \
	 "speedup_clean.csv" using 1:5 with linespoints dashtype 3 pointtype 9 lw 3 lc 3 t "{/Times:Italic mpi-advanced} - Lenses 1500 (14 Bildpaare)"
