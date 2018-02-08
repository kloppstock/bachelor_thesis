set terminal postscript eps color size 2.5, 2
# use the following for terminal latex
#set format "$%g$"
set format "%g"
set datafile separator ","

set key below right
set bmargin 5.7

set xlabel "Kernanzahl"
set ylabel "Speedup"

set key autotitle columnhead
set key box

set grid xtics lc rgb "#888888"
set grid ytics lc rgb "#888888"
set grid

set output "speedup_detector_distortion.eps"
set title "Kernanzahl vs. Speedup\n {/*0.75 Detector Distortion}"
plot "speedup.csv" using 1:2 with linespoints pointtype 5 lw 3
set output "speedup_lenses.eps"
set title "Kernanzahl vs. Speedup\n {/*0.75 Lenses}"
set bmargin 7.7
plot "speedup.csv" using 1:6 with linespoints pointtype 5 lw 3, \
	 "speedup.csv" using 1:7 with linespoints pointtype 7 lw 3, \
	 "speedup.csv" using 1:8 with linespoints pointtype 9 lw 3, \
	 "speedup.csv" using 1:9 with linespoints pointtype 11 lw 3
set output "speedup_exp6.eps"
set title "Kernanzahl vs. Speedup\n {/*0.75 Experiment 6}"
set bmargin 6.7
set key width -8
plot "speedup.csv" using 1:3 with linespoints pointtype 5 lw 3, \
	 "speedup.csv" using 1:4 with linespoints pointtype 7 lw 3, \
	 "speedup.csv" using 1:5 with linespoints pointtype 9 lw 3
