#!/bin/sh
export main="$(pwd)"
function exist_test()
{
	v=$(which $*);
	if [[ $v == *"/bin/$*"* ]]
	then 
		echo "$* exists!" >>$main/wrf_log;
		printf "\n"
	else
		echo "$* not exists!" >>$main/wrf_error;
		exit;
	fi
};
exist_test gfortran
exist_test cpp
exist_test gcc

mkdir TEST
cd TEST
wget -q http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/Fortran_C_tests.tar;
tar -xf Fortran_C_tests.tar;

gfortran TEST_1_fortran_only_fixed.f
fixed_format_fortran_test=$(./a.out);

gfortran TEST_2_fortran_only_free.f90
free_format_fortran_test=$(./a.out);

gcc -c -m64 TEST_4_fortran+c_c.c
gfortran -c -m64 TEST_4_fortran+c_f.f90
gfortran -m64 TEST_4_fortran+c_f.o TEST_4_fortran+c_c.o
c_test=$(./a.out);

csh_test=$(./TEST_csh.csh);
perl_test=$(./TEST_perl.pl);
sh_test=$(./TEST_sh.sh);

function success_test()
{
	printf "$*\n" >>$main/wrf_log;
	if [[ $* != *"SUCCESS"* ]]
        then
		echo "$*" >>$main/wrf_error;
                exit;
        fi
}
success_test $fixed_format_fortran_test
success_test $free_format_fortran_test
success_test $c_test
success_test $csh_test
success_test $perl_test
success_test $sh_test

cd ..
mkdir WRF
cd WRF
mkdir LIBRARIES
cd LIBRARIES
wget -q http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/mpich-3.0.4.tar.gz
wget -q http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/netcdf-4.1.3.tar.gz
wget -q http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/jasper-1.900.1.tar.gz
wget -q http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/libpng-1.2.50.tar.gz
wget -q http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/zlib-1.2.7.tar.gz

export DIR="$(pwd)"
export CC="gcc"
export CXX="g++"
export FC="gfortran"
export FCFLAGS="-m64"
export F77="gfortran"
export FFLAGS="-m64"

tar xzf  netcdf-4.1.3.tar.gz
cd netcdf-4.1.3
./configure --prefix=$DIR/netcdf --disable-dap \
     --disable-netcdf-4 --disable-shared
make
make install
export PATH="$DIR/netcdf/bin:$PATH"
export NETCDF="$DIR/netcdf"
cd ..

tar xzf mpich-3.0.4.tar.gz 
cd mpich-3.0.4
./configure --prefix=$DIR/mpich
make
make install
export PATH="$DIR/mpich/bin:$PATH"
cd ..

export LDFLAGS="-L$DIR/grib2/lib" 
export CPPFLAGS="-I$DIR/grib2/include"
tar xzf zlib-1.2.7.tar.gz 
cd zlib-1.2.7
./configure --prefix=$DIR/grib2
make
make install
cd ..

tar xzf libpng-1.2.50.tar.gz
cd libpng-1.2.50
./configure --prefix=$DIR/grib2
make
make install
cd ..

tar xzf jasper-1.900.1.tar.gz
cd jasper-1.900.1
./configure --prefix=$DIR/grib2
make
make install
cd ..

cd ..
cd ..
cd TEST
wget -q http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/Fortran_C_NETCDF_MPI_tests.tar
tar -xf Fortran_C_NETCDF_MPI_tests.tar

cp ${NETCDF}/include/netcdf.inc .
gfortran -c 01_fortran+c+netcdf_f.f
gcc -c 01_fortran+c+netcdf_c.c
gfortran 01_fortran+c+netcdf_f.o 01_fortran+c+netcdf_c.o \
     -L${NETCDF}/lib -lnetcdff -lnetcdf
v_fortran_c_netcdf=$(./a.out)
success_test $v_fortran_c_netcdf

mpif90 -c 02_fortran+c+netcdf+mpi_f.f
mpicc -c 02_fortran+c+netcdf+mpi_c.c
mpif90 02_fortran+c+netcdf+mpi_f.o \
02_fortran+c+netcdf+mpi_c.o \
     -L${NETCDF}/lib -lnetcdff -lnetcdf
v_mpi=$(mpirun ./a.out)
success_test $v_mpi

cd ..
cd WRF
wget -q http://www2.mmm.ucar.edu/wrf/src/WRFV3.8.TAR.gz
gunzip WRFV3.8.TAR.gz
tar -xf WRFV3.8.TAR
cd WRFV3

