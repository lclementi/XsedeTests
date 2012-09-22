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
apps="apbs namd"
email="clem@sdsc.edu"


function failure(){
    echo -n `date` - ERROR >> tmplog
    if [ "$1" == 'y' ];then 
        echo -n " verification " >> tmplog
    elif [ "$1" == "i" ];then
        echo -n " integrity " >> tmplog 
    fi
    echo >>tmplog
    echo Hostname `hostname` >>tmplog 
    #cat error >> tmplog
    echo >> tmplog
    cat tmplog | mail -s "error `hostname`" $email
    #cat tmplog >> log
    rm tmplog
    #rm error
}



cd /scratch/scratch95/c/clementi/XsedeTests/compile/condor


module load mpich2/1.4.1p1_intel-12.1 
module load intel/12.1 

FILELOG=`hostname`.`date +%m%d%H%M%Y`.log

#verify
for i in $apps; do
    module load $i
    echo Verify $i >> $FILELOG
    fingerprint -y -v -s $i.csv -f $i.swirl >> $FILELOG || failure y $i
    echo Integrity $i >> $FILELOG
    fingerprint -i -v -s $i.csv -f $i.swirl >> $FILELOG || failure i $i
done



