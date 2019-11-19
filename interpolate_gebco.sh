cd $DOMAIN

#load modules
module unload nco cray-netcdf cray-hdf5
module swap PrgEnv-cray PrgEnv-intel
module load cray-netcdf-hdf5parallel
module load cray-hdf5-parallel

#copy the namelist (and change it if necessery)
cp $GITCLONE/FILES_START/DOMAIN/namelist_reshape_bilin_gebco $DOMAIN

#create the bathymetry
$TDIR/WEIGHTS/scripgrid.exe namelist_reshape_bilin_gebco
$TDIR/WEIGHTS/scrip.exe namelist_reshape_bilin_gebco
$TDIR/WEIGHTS/scripinterp.exe namelist_reshape_bilin_gebco

#copy it if you want for safe keeping
cp bathy_meter.nc bathy_meter_gebco.nc

cd $WORK
