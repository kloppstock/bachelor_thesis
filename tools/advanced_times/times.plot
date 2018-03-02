set terminal postscript eps color size 3, 2.3
# use the following for terminal latex
#set format "$%g$"
set format "%g"
set datafile separator ","

set key below right
set bmargin 5.7

set xlabel "Kernanzahl"
set ylabel "Gesamtzeit (in Sekunden)"

set xtics 4
set xrange [0:25]
set logscale y
set yrange [180:22000]
set ytics add ("200" 200) ("20000" 20000)
set key autotitle columnhead
set key box

set grid xtics lc rgb "#888888"
set grid ytics lc rgb "#888888"
set grid

set output "times_detector_distortion.eps"
set title "Gesamtlaufzeit mit steigender Kernanzahl\n {/*0.75 Detector Distortion}"
plot "total_time.csv" using 1:2 with linespoints dashtype 3 pointtype 5 lw 3 t "Detector Distortion (25 Bilder)"
set output "times_lenses.eps"
set title "Gesamtlaufzeit mit steigender Kernanzahl\n {/*0.75 Lenses}"
set bmargin 7.7
plot "total_time.csv" using 1:6 with linespoints dashtype 3 pointtype 5 lw 3 t "Set 1 (10 Bildpaare)", \
	 "total_time.csv" using 1:7 with linespoints dashtype 3 pointtype 7 lw 3 t "Set 2 (5 Bildpaare)", \
	 "total_time.csv" using 1:8 with linespoints dashtype 3 pointtype 9 lw 3 t "Set 3 (1 Bildpaare)", \
	 "total_time.csv" using 1:9 with linespoints dashtype 3 pointtype 11 lw 3 t "Set 3 (2 Bildpaare)"
set output "times_exp6.eps"
set title "Gesamtlaufzeit mit steigender Kernanzahl\n {/*0.75 Experiment 6}"
set ytics auto
set yrange [1000:22000]
set ytics add ("20000" 20000)
set bmargin 6.7
plot "total_time.csv" using 1:3 with linespoints dashtype 3 pointtype 5 lw 3 t "Lenses 200 (21 Bildpaare)", \
	 "total_time.csv" using 1:4 with linespoints dashtype 3 pointtype 7 lw 3 t "Lenses 500 (11 Bildpaare)", \
	 "total_time.csv" using 1:5 with linespoints dashtype 3 pointtype 9 lw 3 t "Lenses 1500 (14 Bildpaare)"
