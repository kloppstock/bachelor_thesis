set terminal postscript eps color size 2.5, 2
# use the following for terminal latex
#set format "$%g$"
set format "%g"
set datafile separator ","

set key below right
set bmargin 5.7

set logscale y
set xrange[1:24]
set xtics 4
set xlabel "Kernanzahl"
set ylabel "Rundenzeit (in Sekunden)"

set key autotitle columnhead
set key box

set grid xtics lc rgb "#888888"
set grid ytics lc rgb "#888888"
set grid

set output "round_times_detector_distortion.eps"
set title "Kernanzahl vs. Rundenzeit\n {/*0.75 Detector Distortion}"
plot "round_time.csv" using 1:2 with linespoints pointtype 5 lw 3
set output "round_times_lenses.eps"
set title "Kernanzahl vs. Rundenzeit\n {/*0.75 Lenses}"
set bmargin 7.7
set key width 0
plot "round_time.csv" using 1:6 with linespoints pointtype 5 lw 3, \
	 "round_time.csv" using 1:7 with linespoints pointtype 7 lw 3, \
	 "round_time.csv" using 1:8 with linespoints pointtype 9 lw 3, \
	 "round_time.csv" using 1:9 with linespoints pointtype 11 lw 3
set output "round_times_exp6.eps"
set title "Kernanzahl vs. Rundenzeit\n {/*0.75 Experiment 6}"
set bmargin 6.7
set key width -8
plot "round_time.csv" using 1:3 with linespoints pointtype 5 lw 3, \
	 "round_time.csv" using 1:4 with linespoints pointtype 7 lw 3, \
	 "round_time.csv" using 1:5 with linespoints pointtype 9 lw 3
