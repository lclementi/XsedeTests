#!/bin/bash
#PBS -q normal
#PBS -l nodes=1:ppn=8:native
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


echo The working directory is $PBS_O_WORKDIR 

cd $PBS_O_WORKDIR 
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH


mpirun_rsh -np 8 -hostfile $PBS_NODEFILE ../bin/bin/apbs apbs-mol.in > apbs-mol.out


