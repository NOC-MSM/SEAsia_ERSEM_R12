cd $DOMAIN

#load modules
module unload nco cray-netcdf cray-hdf5
module swap PrgEnv-cray PrgEnv-intel
module load cray-netcdf-hdf5parallel
module load cray-hdf5-parallel

#cp or download bathymetry from the ORCA 12 global
cp $GITCLONE/DOMAIN/eORCA12_bathymetry_v2.4.nc $DOMAIN

#copy the namelist (and change it if necessery)
cp $GITCLONE/DOMAIN/namelist_reshape_bilin_eORCA12 $DOMAIN

#create the bathymetry
$TDIR/WEIGHTS/scripgrid.exe namelist_reshape_bilin_gebco
$TDIR/WEIGHTS/scrip.exe namelist_reshape_bilin_gebco
$TDIR/WEIGHTS/scripinterp.exe namelist_reshape_bilin_gebco

#load nco modules
module unload cray-netcdf-hdf5parallel cray-hdf5-parallel
module load cray-netcdf cray-hdf5
module load nco/4.5.0


#copy it if you want for safe keeping
cp bathy_meter.nc bathy_meter_gebco.nc

cd $WORK
