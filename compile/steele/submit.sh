#!/bin/bash
###PBS -q tg_short
#PBS -q standby-8
###PBS -l nodes=gcn-4-73
##PBS -l nodes=1:ppn=8:native
#PBS -l nodes=1
#PBS -l walltime=00:15:00
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
apps="apbs namd"


function failure(){
    echo we have a failure
    echo -n `date` - ERROR >> tmplog
    if [ "$1" == 'y' ];then 
        echo -n " verification " >> tmplog
    elif [ "$1" == "i" ];then
        echo -n " integrity " >> tmplog 
    elif [ "$1" == "t" ];then
        echo -n " test " >> tmplog
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


cd /scratch/scratch95/c/clementi/XsedeTests/compile/steele
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD/namd/fftwbin/lib/

module load mpich2/1.4.1p1_intel-12.1 
module load intel/12.1 

export PATH=/usr/sbin:$PATH

FILELOG=`hostname`.`date +%m%d%H%M%Y`.log

#fingerprint -c -f namd2.swirl -l namdFile
#fingerprint -c -f apbs2.swirl -l apbsFile

#verify
for i in $apps; do
    echo Verify $i >> $FILELOG
    fingerprint -y -v -s $i.csv -f $i.swirl >> $FILELOG || failure y $i
    echo Integrity $i >> $FILELOG
    fingerprint -i -v -s $i.csv -f $i.swirl >> $FILELOG || failure i $i
done

#let's run the test script
for i in $apps; do
    cd $i/test
    ./test.sh || failure t  $i
    cd -
done 

#VERIFY_LIBS="/usr/lib64/libibumad.so.3.0.2 /usr/lib64/libibverbs.so.1.0.0 /usr/lib64/librdmacm.so.1.0.0"
#
#for i in $VERIFY_LIBS;
#do
#	prelink --verify --md5 $i >> $FILELOG
#	cp $i .
#done
#

