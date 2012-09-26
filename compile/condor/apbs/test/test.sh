#!/bin/bash

module load mpich2/1.4.1p1_intel-12.1 

rm hostfile
for i in `seq 1 8`;do 
    echo `hostname` >> hostfile ;
done

mpirun -np 8 -hostfile hostfile ../bin/bin/apbs apbs-mol-parallel.in

