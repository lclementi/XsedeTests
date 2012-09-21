#
# Clementi Luca
# Compile apbs on godon 09/11/2012
#



SOURCE = APBS-1.4-source
APBSDIR = APBS-1.4
EXT = tar.gz
FFTW=fftw-3.3.2

MPICH2_DIR = /apps/rhel5/mpich2-1.4.1p1/64/nemesis-intel-12.1
MODULE_LOAD = module load mvapich2_ib;\
           module load intel; module load fftw; \
           export CC=icc F77=ifort LDFLAGS=" -L$(MPICH2_DIR)/lib/ -lmpl"

FFTW_PATH = $(CURDIR)/fftwbin

#intel compiler
FCC = ifort
CXX = icpc        
CC = icc




default: install


install: build
	mkdir -p $(CURDIR)/bin
	cd $(APBSDIR); make install



build: getSource
	#$(APBSDIR); vexport LDFLAGS="-L/opt/mvapich2/intel/ib/lib -lmpl "; 
	cd $(APBSDIR); $(MODULE_LOAD); \
		./configure --with-mpich2=$(MPICH2_DIR) --prefix=$$PWD/../bin
	cd $(APBSDIR); $(MODULE_LOAD); make 


getSource: 
	tar -xvzf ../../../apps/apbs/$(SOURCE).$(EXT)




clean::
	rm -rf $(APBSDIR) bin

