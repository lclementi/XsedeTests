


module load mpich2/1.4.1p1_intel-12.1 
module load intel/12.1 

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PWD/namd/fftwbin/lib/
export PATH=/usr/sbin:$PATH


fingerprint -c -l apbsFile -f apbs.swirl 
fingerprint -c -l namdFile -f namd.swirl 

