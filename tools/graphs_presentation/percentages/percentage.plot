set terminal postscript eps color size 3.1, 3.1
set encoding utf8
set format '%g%%'
# use the following for terminal latex
#set format "$%g$"
set ylabel "Anteil"
set key autotitle columnhead
set yrange [0:100]
set xtics rotate by -25

set style data histogram
set style histogram rowstacked
set datafile separator ","
set boxwidth 0.8

set key below
set key box

set output "speckle_lenses.eps"
set title "Anteil der Laufzeit der Speckle-Tracking-Subroutinen\n {/*0.75 Lenses}"
plot 'speckle_lenses.csv' \
	 using($2):xtic(1) fs pattern 3,\
''   using($3) fs pattern 3,\
''   using($4) fs pattern 3,\
''   using($5) fs pattern 3,\
''   using($6) fs pattern 3

set output "slow_lenses.eps"
set title "Anteil der Laufzeit der rechenaufwendigsten Funktionen\n {/*0.75 Lenses}"
plot 'slow_lenses.csv' \
	 using($2):xtic(1) fs pattern 3,\
''   using($3) fs pattern 3,\
''   using($4) fs pattern 3,\
''   using($5) fs pattern 3,\
''   using($6) fs pattern 3

set output "main_lenses.eps"
set title "Anteil der Laufzeit der Subroutinen\n {/*0.75 Lenses}"
plot 'main_lenses.csv' \
	 using($2):xtic(1) fs pattern 3,\
''   using($3) fs pattern 3,\
''   using($4) fs pattern 3


set output "speckle_exp6.eps"
set title "Anteil der Laufzeit der Speckle-Tracking-Subroutinen\n {/*0.75 Experiment 6}"
plot 'speckle_exp6.csv' \
	 using($2):xtic(1) fs pattern 3,\
''   using($3) fs pattern 3,\
''   using($4) fs pattern 3,\
''   using($5) fs pattern 3,\
''   using($6) fs pattern 3

set output "slow_exp6.eps"
set title "Anteil der Laufzeit der rechenaufwendigsten Funktionen\n {/*0.75 Experiment 6}"
plot 'slow_exp6.csv' \
	 using($2):xtic(1) fs pattern 3,\
''   using($3) fs pattern 3,\
''   using($4) fs pattern 3,\
''   using($5) fs pattern 3,\
''   using($6) fs pattern 3

set output "main_exp6.eps"
set title "Anteil der Laufzeit der Subroutinen\n {/*0.75 Experiment 6}"
plot 'main_exp6.csv' \
	 using($2):xtic(1) fs pattern 3,\
''   using($3) fs pattern 3,\
''   using($4) fs pattern 3
