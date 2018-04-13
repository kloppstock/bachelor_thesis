set terminal postscript eps color enhanced size 3, 3
set encoding utf8
set format '%g'
# use the following for terminal latex
#set format "$%g$"
set ylabel "Speedup"
set key autotitle columnhead
set xtics rotate by -25

set style histogram clustered
set datafile separator ","
set style fill solid

set key below
set key box

set yrange [0.9:1.6]
set xrange [-0.4:3.7]
set boxwidth 1.8

set output "speedups_intrinsics_lenses.eps"
set title "Speedups gegenüber der {/Times:Italic mpi-advanced}-Implementierung\n {/*0.75 Lenses}"
plot 'speedups_intrinsics_lenses.csv' \
	 using($2):xtic(1) with histograms,\
	1 with lines lc 7 lw 4 t "{/Times:Italic mpi-advanced}"

set xrange [-0.4:2.7]
set yrange [0.9:4.2]
set output "speedups_intrinsics_exp6.eps"
set title "Speedups gegenüber der {/Times:Italic mpi-advanced}-Implementierung\n {/*0.75 Experiment 6}"
plot 'speedups_intrinsics_exp6.csv' \
	 using($2):xtic(1) with histograms,\
	1 with lines lc 7 lw 4 t "{/Times:Italic mpi-advanced}"
