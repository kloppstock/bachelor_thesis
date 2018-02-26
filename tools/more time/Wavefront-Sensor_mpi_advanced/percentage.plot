set terminal postscript eps color size 6, 4
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

set output "speckle.eps"
set title "Anteil der Laufzeit der Speckle-Tracking-Subroutinen"
plot 'speckle.csv' \
	 using($2):xtic(1) fs pattern 3,\
''   using($3) fs pattern 3,\
''   using($4) fs pattern 3,\
''   using($5) fs pattern 3,\
''   using($6) fs pattern 3

set output "slow.eps"
set title "Anteil der Laufzeit der rechenaufwendigsten Funktionen"
plot 'slow.csv' \
	 using($2):xtic(1) fs pattern 3,\
''   using($3) fs pattern 3,\
''   using($4) fs pattern 3,\
''   using($5) fs pattern 3,\
''   using($6) fs pattern 3

set output "main.eps"
set title "Anteil der Laufzeit der Subroutinen"
plot 'main.csv' \
	 using($2):xtic(1) fs pattern 3,\
''   using($3) fs pattern 3,\
''   using($4) fs pattern 3
