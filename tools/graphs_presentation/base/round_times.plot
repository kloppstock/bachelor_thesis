set terminal postscript eps color size 2.5, 2 font "Times,13"
# use the following for terminal latex
#set format "$%g$"
set format "%g"
set datafile separator ","

set key below right
set bmargin 5.7

set logscale y
set xrange[0:25]
set yrange [90:2200]
set ytics add ("2000" 2000)
set xtics 4
set xlabel "Kernanzahl"
set ylabel "Rundenzeit (in Sekunden)"

set key autotitle columnhead
set key box

set grid xtics lc rgb "#888888"
set grid ytics lc rgb "#888888"
set grid

set output "round_times_detector_distortion.eps"
set title "Rundenzeit mit steigender Kernanzahl\n {/*0.75 Detector Distortion}"
plot "round_time.csv" using 1:2 with linespoints dashtype 3 pointtype 5 lw 3 t "Detector Distortion (25 Bilder)"
set output "round_times_lenses.eps"
set title "Rundenzeit mit steigender Kernanzahl\n {/*0.75 Lenses}"
set bmargin 7.7
set key width 0
plot "round_time.csv" using 1:6 with linespoints dashtype 3 pointtype 5 lw 3 t "Set 1 (10 Bildpaare)", \
	 "round_time.csv" using 1:7 with linespoints dashtype 3 pointtype 7 lw 3 t "Set 2 (5 Bildpaare)", \
	 "round_time.csv" using 1:8 with linespoints dashtype 3 pointtype 9 lw 3 t "Set 3 (1 Bildpaar)", \
	 "round_time.csv" using 1:9 with linespoints dashtype 3 pointtype 11 lw 3 t "Set 3 (2 Bildpaare)"
set output "round_times_exp6.eps"
set title "Rundenzeit mit steigender Kernanzahl\n {/*0.75 Experiment 6}"
set bmargin 6.7
set yrange [95:630]
set ytics auto
set ytics add ("600" 600)
plot "round_time.csv" using 1:3 with linespoints dashtype 3 pointtype 5 lw 3 t "Lenses 200 (21 Bildpaare)", \
	 "round_time.csv" using 1:4 with linespoints dashtype 3 pointtype 7 lw 3 t "Lenses 500 (11 Bildpaare)", \
	 "round_time.csv" using 1:5 with linespoints dashtype 3 pointtype 9 lw 3 t "Lenses 1500 (14 Bildpaare)"
