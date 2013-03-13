#!/bin/bash


. /etc/profile



echo Runing on `hostname`
date
apps="apbs autodock"
email="clem@sdsc.edu"


function failure(){
    echo -n `date` - ERROR >> tmplog
    if [ "$1" == 'y' ];then 
        echo -n " verification " >> tmplog
    elif [ "$1" == "i" ];then
        echo -n " integrity " >> tmplog 
    fi
    echo $2 >>tmplog
    echo Hostname `hostname` >>tmplog 
    #cat error >> tmplog
    echo >> tmplog
}


export PATH=/usr/sbin:$PATH:FingerPrint/bin


FILELOG=`hostname`.`date +%m%d%H%M%Y`.log

#verify
for i in $apps; do
    echo Verify $i >> $FILELOG
    fingerprint -y -v -s $i.csv -f $i.swirl >> $FILELOG || failure y $i
    #echo Integrity $i >> $FILELOG
    #fingerprint -i -v -s $i.csv -f $i.swirl >> $FILELOG || failure i $i
done



