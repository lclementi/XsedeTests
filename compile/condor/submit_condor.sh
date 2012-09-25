#!/bin/bash


. /etc/profile
. /home/ba01/u102/clementi/.bashrc 


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
    echo $2 >> tmplog
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
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD/namd/fftwbin/lib/

module load mpich2/1.4.1p1_intel-12.1 
module load intel/12.1 

export PATH=/usr/sbin:$PATH

FILELOG=`hostname`.`date +%m%d%H%M%Y`.log

#create

#verify
for i in $apps; do
    echo Verify $i >> $FILELOG
    fingerprint -y -v -s $i.csv -f $i.swirl >> $FILELOG || failure y $i
    echo Integrity $i >> $FILELOG
    fingerprint -i -v -s $i.csv -f $i.swirl >> $FILELOG || failure i $i
done


for i in "libgcc glibc libstdc++";do
    rpm -q $i
done
