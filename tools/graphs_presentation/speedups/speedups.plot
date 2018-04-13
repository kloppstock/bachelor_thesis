set terminal postscript eps color enhanced size 3.5, 3
set encoding utf8
set format '%g'
# use the following for terminal latex
#set format "$%g$"
set ylabel "Speedup"
set yrange [0.7:1.1]
set xrange [-0.4:3.6]
set key autotitle columnhead
set xtics rotate by -25

set style histogram clustered
set datafile separator ","
set boxwidth 0.95
set style fill solid

set key below
set key box

set output "speedups_lenses.eps"
set title "Speedups gegenüber {/Times:Italic intrinsics}\n {/*0.75 Lenses}"
plot 'speedups_lenses.csv' using($3):xtic(1) with histograms,\
	'speedups_lenses.csv'   using($4) with histograms,\
	'speedups_lenses.csv'   using($5) with histograms,\
	'speedups_lenses.csv'   using($2) with histograms,\
	1 with lines lc 7 lw 4 t "{/Times:Italic intrinsics}"


set xrange [-0.4:2.6]
set output "speedups_exp6.eps"
set title "Speedups gegenüber {/Times:Italic intrinsics}\n {/*0.75 Experiment 6}"
plot 'speedups_exp6.csv' using($3):xtic(1) with histograms,\
	'speedups_exp6.csv'   using($4) with histograms,\
	'speedups_exp6.csv'   using($5) with histograms,\
	'speedups_exp6.csv'   using($2) with histograms,\
	1 with lines lc 7 lw 4 t "{/Times:Italic intrinsics}"
