#!/bin/sh

for FOLDER in "base" "compiled_new_best" "mpi" "mpi_advanced" "percentages" "speedups"
do
	echo $FOLDER
	cd $FOLDER
	sh build.sh
	cd ..
done
