cd $TDIR

#load modules
module unload nco cray-netcdf cray-hdf5
module load cray-netcdf-hdf5parallel/4.4.1.1
module load cray-hdf5-parallel/1.10.0.1
module swap PrgEnv-cray PrgEnv-intel/5.2.82

#take namelist (!!modify it if necessary) 
cp $GITCLONE/DOMAIN/namelist_cfg $TDIR/DOMAINcfg/namelist_cfg

#link coordinates and bathymeter
ln -s $DOMAIN/coordinates.nc $TDIR/DOMAINcfg/.
ln -s $DOMAIN/bathy_meter_gebco.nc $TDIR/DOMAINcfg/bathy_meter.nc

#copy file for z-s hybrid namdom
cp $GITCLONE/DOMAIN/domzgr_jelt_changes.f90 $TDIR/DOMAINcfg/src/domzgr.f90

cd $TDIR

#recompile
#sometimes it does not work the direct recompile (do not know why maybe changes in XIOS use) 
#use so the following is a trick works for some reason
./maketools -n NESTING -m XC_ARCHER_INTEL_NOXIOS -j 6
./maketools -m XC_ARCHER_INTEL_XIOS1 -n DOMAINcfg clean
./maketools -m XC_ARCHER_INTEL_XIOS1 -n DOMAINcfg

cd $TDIR/DOMAINcfg

#you have to submit the domain creation as a job so copy the jobs script and 
# modify accordingly 
cp $GITCLONE/DOMAIN/job_create.sh $TDIR/DOMAINcfg/job_create.sh
qsub -q short job_create.sh

#after create copy it and store it for durther use
cp $TDIR/DOMAINcfg/domain_cfg.nc $DOMAIN/domain_cfg_gebco.nc

cd $WORK

