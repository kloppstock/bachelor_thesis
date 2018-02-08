set terminal postscript eps color size 2.5, 2
# use the following for terminal latex
#set format "$%g$"
set format "%g"
set datafile separator ","

set key below right
set bmargin 5.7

set xlabel "Kernanzahl"
set ylabel "Gesamtzeit (in Sekunden)"

set key autotitle columnhead
set key box

set grid xtics lc rgb "#888888"
set grid ytics lc rgb "#888888"
set grid

set output "times_detector_distortion.eps"
set title "Kernanzahl vs. Gesamtzeit\n {/*0.75 Detector Distortion}"
plot "total_time.csv" using 1:2 with linespoints pointtype 5 lw 3
set output "times_lenses.eps"
set title "Kernanzahl vs. Gesamtzeit\n {/*0.75 Lenses}"
set bmargin 7.7
plot "total_time.csv" using 1:6 with linespoints pointtype 5 lw 3, \
	 "total_time.csv" using 1:7 with linespoints pointtype 7 lw 3, \
	 "total_time.csv" using 1:8 with linespoints pointtype 9 lw 3, \
	 "total_time.csv" using 1:9 with linespoints pointtype 11 lw 3
set output "times_exp6.eps"
set title "Kernanzahl vs. Gesamtzeit\n {/*0.75 Experiment 6}"
set bmargin 6.7
set key width -8
plot "total_time.csv" using 1:3 with linespoints pointtype 5 lw 3, \
	 "total_time.csv" using 1:4 with linespoints pointtype 7 lw 3, \
	 "total_time.csv" using 1:5 with linespoints pointtype 9 lw 3
