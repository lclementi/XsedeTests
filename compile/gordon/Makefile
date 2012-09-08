#
# $Id: nadya Williams $
#
# @Copyright@
# @Copyright@



SOURCE = NAMD_2.9_Source
EXT = tar.gz
CHARMVER = 6.4.0

MODULE_LOAD = module load mvapich2_ib;\
           module load intel; module load fftw

FFTW_PATH = /opt/fftw/3.3/intel/mvapich2

#intel compiler
FCC = ifort
CHARMARCH = mpi-linux-x86_64-$(FCC)-mpicxx
CHARMBUILDOPTS = mpicxx $(FCC) -j16 -O2  -xHOST
CXX = icpc        
CC = icc
NAMDOPT = --fftw-prefix $(FFTW_PATH) --with-fftw3 --without-tcl --charm-arch $(CHARMARCH)


default: build

build: getSource
	( \
	  $(MODULE_LOAD); \
	  cd $(SOURCE)/charm-$(CHARMVER); \
	  env MPICXX=mpicxx ./build charm++ mpi-linux-x86_64 $(CHARMBUILDOPTS); \
	  cd $(CHARMARCH)/tests/charm++/megatest; \
	  make pgm; \
	)
	#charm test
	-$(MODULE_LOAD); cd $(SOURCE)/charm-$(CHARMVER)/$(CHARMARCH)/tests/charm++/megatest; \
	  $${MPIHOME}/bin/mpirun -n 4 ./pgm; 
	(\
	  cd $(SOURCE); \
	  ./config Linux-x86_64-$(CC) $(NAMDOPT) ; \
	  cd Linux-x86_64-$(CC); \
	  make -j8 \
	)

getSource: ../../apps/namd/$(SOURCE).$(EXT) ../../apps/namd/tiny.tar.gz
	cp ../../apps/namd/$(SOURCE).$(EXT) .
	cp ../../apps/namd/tiny.tar.gz .
	tar zxf $(SOURCE).$(EXT)
	tar zxf tiny.tar.gz
	#cd patch-files && find . -type f | grep -v CVS | cpio -pduv ../
	cd $(SOURCE) && tar xf charm-$(CHARMVER).tar
	patch -p0 < patch


install::
	mkdir -p -m 755 $(ROOT)/$(PKGROOT)/bin
	cp $(SOURCE)/*/{charmrun,flipbinpdb,flipdcd,namd2,psfgen} \
	   $(ROOT)/$(PKGROOT)/bin
	cp -r tiny $(ROOT)/$(PKGROOT)

clean::
	rm -rf $(SOURCE) $(SOURCE).tar.gz tiny tiny.tar.gz
