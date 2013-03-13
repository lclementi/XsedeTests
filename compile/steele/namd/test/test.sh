#!/bin/bash
###PBS -q tg_short
###PBS -q tg_debug
#PBS -q standby-8
###PBS -l nodes=gcn-4-73
##PBS -l nodes=1:ppn=8:native
#PBS -l nodes=1
#PBS -l walltime=00:14:00
#PBS -N testFingerPrintCompute
#PBS -o output
#PBS -e error
#PBS -A TG-CCR120041
#PBS -M clem@sdsc.edu
#PBS -m abe
#PBS -V
# Start of user commands - comments start with a hash sign (#)



echo Runing on `hostname`
date
email="clem@sdsc.edu"



export PATH=/usr/sbin:$PATH:/home/clementi/FingerPrint/bin

cd /scratch/scratch95/c/clementi/XsedeTests/compile/steele
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD/namd/fftwbin/lib/

module load mpich2/1.4.1p1_intel-12.1 
module load intel/12.1 



cd namd/tiny
mpirun -np 8 -hostfile $PBS_NODEFILE ./../bin/namd2 tiny.namd


