#!/bin/bash
#PBS -q normal
#PBS -l nodes=gcn-4-73
###PBS -l nodes=1:ppn=8:native
#PBS -l walltime=00:03:00
#PBS -N testFingerPrintCompute
#PBS -o output
#PBS -e error
#PBS -A sds138
#PBS -M clem@sdsc.edu
#PBS -m abe
#PBS -V
# Start of user commands - comments start with a hash sign (#)

echo Runing on `hostname`
date
email="clem@sdsc.edu"


cd /oasis/scratch/clem/temp_project/XsedeTests/compile/gordon/namd
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD/fftwbin/lib/


cd tiny
mpirun_rsh -np 8 -hostfile $PBS_NODEFILE ./../bin/namd2 tiny.namd


