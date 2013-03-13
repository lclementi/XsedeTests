#!/bin/bash


EMAIL='clem@sdsc.edu'

while [ true ] ; do

	sleep 300
	if [ -f tmplog ]; then
		cat tmplog | mail -s "error `hostname`" $EMAIL
		#cat tmplog >> log
		rm tmplog
	fi
done

