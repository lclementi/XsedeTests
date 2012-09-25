#
# Clementi Luca
# Compile apbs on godon 09/11/2012
#



SOURCE = autodocksuite-4.2.3-src.tar.gz
PKGROOT = $(CURDIR)

MODULE_LOAD = module load intel/12.1 ;\
           export CC=icc F77=ifort 

#intel compiler
FCC = ifort
CXX = icpc        
CC = icc


default: install


install: build
	mkdir -p $(PKGROOT)
	( cd src/autodock;  make install )
	( cd src/autogrid;  make install )



build: getSource
	( cd src/autodock; ./configure --prefix=$(PKGROOT); make; )
	( cd src/autogrid; ./configure --prefix=$(PKGROOT); make; )
	

getSource: 
	tar -xvzf ../../../apps/autodock/$(SOURCE)


clean::
	rm -rf src bin

