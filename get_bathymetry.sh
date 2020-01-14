cd $DOMAIN

#load modules
module unload nco cray-netcdf cray-hdf5
module swap PrgEnv-cray PrgEnv-intel
module load cray-netcdf-hdf5parallel
module load cray-hdf5-parallel

#cp or download bathymetry from the ORCA 12 global
cp /work/n01/n01/annkat/EXTRA_TOOLS/BATH/eORCA12_bathymetry_v2.4.nc $DOMAIN

#copy the namelist (and change it if necessery)
cp $GITCLONE/DOMAIN/namelist_reshape_bilin_eORCA12 $DOMAIN

#create the bathymetry
$TDIR/WEIGHTS/scripgrid.exe namelist_reshape_bilin_eORCA12
$TDIR/WEIGHTS/scrip.exe namelist_reshape_bilin_eORCA12
$TDIR/WEIGHTS/scripinterp.exe namelist_reshape_bilin_eORCA12

#load nco modules
module unload cray-netcdf-hdf5parallel cray-hdf5-parallel
module load cray-netcdf cray-hdf5
module load nco/4.5.0

#remove weirdness with negative bathymetry and make minimum bathymetry
#equal to 10 m (resolve any possible wet-drying problems)
ncap2 -s 'where(Bathymetry < 0) Bathymetry=0' bathy_meter.nc tmp1.nc
ncap2 -s 'where(Bathymetry < 10 && Bathymetry > 0) Bathymetry=10' tmp1.nc -O bathy_meter.nc
rm tmp1.nc

#copy it if you want for safe keeping
cp bathy_meter.nc bathy_meter_ORCA12.nc

#fix bathymetry to deal with instabilities (opening some straights that
#have only 2 grid points)
ncap2 -s 'Bathymetry(140,464)=200' bathy_meter_ORCA12.nc bathy_meter_ORCA12.nc -O
ncap2 -s 'Bathymetry(141,464)=200' bathy_meter_ORCA12.nc bathy_meter_ORCA12.nc -O
ncap2 -s 'Bathymetry(145,563)=400' bathy_meter_ORCA12.nc bathy_meter_ORCA12.nc -O
ncap2 -s 'Bathymetry(145,564)=400' bathy_meter_ORCA12.nc bathy_meter_ORCA12.nc -O
ncap2 -s 'Bathymetry(140,467)=80' bathy_meter_ORCA12.nc bathy_meter_ORCA12.nc -O

cd $WORK
