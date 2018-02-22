#!/bin/bash

# define core counts
CORES_COMPILED="12"
CORES_CYTHON="8	11	12	13	16	20	24	48	72	96	120"
CORES_INTRINSICS="8	11	12	13	16	20	24	48	72	96	120"
CORES_MPI="" #"12 24 48" not done yet
CORES_MPI_ADVANCED="12	24	48"
CORES_NUMBA="12"

CORE_CONFIGS[0]=$CORES_COMPILED
CORE_CONFIGS[1]=$CORES_CYTHON
CORE_CONFIGS[2]=$CORES_INTRINSICS
CORE_CONFIGS[3]=$CORES_MPI
CORE_CONFIGS[4]=$CORES_MPI_ADVANCED
CORE_CONFIGS[5]=$CORES_NUMBA

PATHS=("Wavefront-Sensor_compiled_new/" "Wavefront-Sensor_cython/" "Wavefront-Sensor_intrinsics/" "Wavefront-Sensor_mpi/" "Wavefront-Sensor_mpi_advanced/" "Wavefront-Sensor_numba/")

# copy scripts
for I in 0 1 2 3 4 5 ; do
	echo "chopping down ${PATHS[$I]} with configs ${CORE_CONFIGS[$I]}"
	cp round_times.plot ${PATHS[$I]}
	cp times.plot ${PATHS[$I]}
	cp speedup.plot ${PATHS[$I]}
	cp percentage.plot ${PATHS[$I]}
	cp woodworker.py ${PATHS[$I]}
	cd ${PATHS[$I]}
	python woodworker.py . 4 1 ${CORE_CONFIGS[$I]}
	gnuplot round_times.plot
	gnuplot times.plot
	gnuplot speedup.plot
	cd ..
done

