#!/bin/sh

gnuplot round_times.plot
gnuplot round_times_mpi.plot
gnuplot speedup_mpi.plot
gnuplot times_mpi.plot
