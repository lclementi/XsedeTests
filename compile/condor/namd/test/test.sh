#!/bin/bash

echo Runing on `hostname`
date
email="clem@sdsc.edu"

module load mpich2/1.4.1p1_intel-12.1

rm -f hostfile
for i in `seq 1 8`;do 
    echo `hostname` >> hostfile ;
done

cd ../tiny
mpirun -np 8 -hostfile ../test/hostfile ../bin/namd2 tiny.namd 



