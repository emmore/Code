#! /bin/csh 
mkdir TESTS
cd TESTS
gcc --version >>LogFile
wget http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/Fortran_C_tests.tar

tar -xf Fortran_C_tests.tar

gfortran TEST_1_fortran_only_fixed.f
./a.out >>LogFile
gfortran TEST_2_fortran_only_free.f90
./a.out >>LogFile


