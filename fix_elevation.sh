cd $DOMAIN

#load modules
module unload cray-netcdf-hdf5parallel cray-hdf5-parallel
module load cray-netcdf cray-hdf5
module load nco/4.5.0

#cp or download the gebco bathymetry
cp $GITCLONE/DOMAIN/GRIDONE_2008_2D_74.0_-21.0_134.0_25.0.nc $DOMAIN

#make sure you remove any elevation for land and fix the record
ncap2 -s 'where(elevation > 0) elevation=0' GRIDONE_2008_2D_74.0_-21.0_134.0_25.0.nc tmp.nc
ncflint --fix_rec_crd -w -1.0,0.0 tmp.nc tmp.nc gebco_in.nc

rm tmp.nc

cd $WORK
