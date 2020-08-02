#!/bin/sh
export OMP_PLACES=cores
export OMP_CPU_BIND=true
./stream_triad
./stream_triad_opt1
./stream_triad_opt2
./stream_triad_opt3
./stream_triad_opt4
