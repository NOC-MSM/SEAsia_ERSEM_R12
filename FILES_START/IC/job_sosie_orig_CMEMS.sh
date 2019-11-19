#!/bin/bash
#PBS -N init_T
#PBS -l select=serial=true:ncpus=1
#PBS -l walltime=06:00:00
#PBS -o init_T.log
#PBS -e init_T.err
#PBS -A n01-ACCORD
###################################################

module swap PrgEnv-cray PrgEnv-intel
module load cray-hdf5-parallel
module load cray-netcdf-hdf5parallel

cd /home/n01/n01/annkat/sosie
make clean
make
make install

#set up paths
cd /work/n01/n01/annkat/SEAsia_ERSEM_CMEMS/INITIAL_CONDITIONS/

/home/n01/n01/annkat/local/bin/sosie3.x -f initcd_votemper_orig.namelist

# qsub -q serial <filename>
###################################################
