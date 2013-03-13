#
# Clementi Luca
# Compile apbs on godon 09/11/2012
#



SOURCE = APBS-1.4-source
APBSDIR = APBS-1.4
EXT = tar.gz


MODULE_LOAD = module load intel/12.1 ;\
           export CC=icc F77=ifort 

#intel compiler
FCC = ifort
CXX = icpc        
CC = icc




default: install


install: build
	mkdir -p $(CURDIR)/bin
	cd $(APBSDIR); $(MODULE_LOAD); make install



build: getSource
	#$(APBSDIR); vexport LDFLAGS="-L/opt/mvapich2/intel/ib/lib -lmpl "; 
	cd $(APBSDIR); $(MODULE_LOAD); \
		./configure --prefix=$$PWD/../bin
	cd $(APBSDIR); $(MODULE_LOAD); make 


getSource: 
	tar -xvzf ../../../apps/apbs/$(SOURCE).$(EXT)


clean::
	rm -rf $(APBSDIR) bin

