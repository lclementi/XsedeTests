#
# $Id: nadya Williams $
#
# @Copyright@
# @Copyright@



SOURCE = NAMD_2.9_Source
EXT = tar.gz
CHARMVER = 6.4.0
FFTW=fftw-3.3.2

MODULE_LOAD = module load mvapich2_ib;\
           module load intel; module load fftw; \
           export CC=icc F77=ifort LDFLAGS=-L/opt/mvapich2/intel/ib/lib/

FFTW_PATH = $(CURDIR)/fftwbin

#intel compiler
FCC = ifort
CHARMARCH = mpi-linux-x86_64-$(FCC)-mpicxx
CHARMBUILDOPTS = mpicxx $(FCC) -j16 -O2  -xHOST
CXX = icpc        
CC = icc
NAMDOPT = --fftw-prefix $(FFTW_PATH) --with-fftw3 --without-tcl --charm-arch $(CHARMARCH)


default: install

#build: getSource build-fftw
build: getSource build-fftw
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
	  cd $(SOURCE); export LD_LIBRARY_PATH=$$LD_LIBRARY_PATH:$(CURDIR)/fftwbin/lib/; \
	  ./config Linux-x86_64-$(CC) $(NAMDOPT) ; \
	  cd Linux-x86_64-$(CC); \
	  make -j8 \
	)

getSource: 
	tar zxf ../../apps/namd/$(SOURCE).$(EXT)
	tar zxf ../../apps/namd/tiny.tar.gz
	#cd patch-files && find . -type f | grep -v CVS | cpio -pduv ../
	cd $(SOURCE) && tar xf charm-$(CHARMVER).tar
	#patch -p0 < patch


build-fftw: getSource-fftw
	cd $(FFTW); $(MODULE_LOAD); \
	./configure --enable-mpi --enable-threads  --enable-sse --enable-sse2 --enable-avx --enable-float --enable-shared --prefix=$$PWD/../fftwbin
	cd $(FFTW); $(MODULE_LOAD); make -j4; make install

getSource-fftw:
	tar -xvzf ../../apps/namd/$(FFTW).tar.gz


install: build
	mkdir -p -m 755 $(CURDIR)/bin
	cp $(SOURCE)/*/{charmrun,flipbinpdb,flipdcd,namd2,psfgen} \
	   $(CURDIR)/bin

clean::
	rm -rf $(SOURCE) $(SOURCE).tar.gz tiny tiny.tar.gz $(FFTW) fftwbin bin
