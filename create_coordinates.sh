cd $TDIR/NESTING

#load modules
module unload nco cray-netcdf cray-hdf5
module swap PrgEnv-cray PrgEnv-intel
module load cray-netcdf-hdf5parallel
module load cray-hdf5-parallel

# subdomain of ORCA global
ln -s $GITCLONE/FILES_START/DOMAIN/coordinates_ORCA_R12.nc $TDIR/NESTING/.
cp $GITCLONE/FILES_START/DOMAIN/namelist.input $TDIR/NESTING/

./agrif_create_coordinates.exe

#copy it to you DOMAIN to safe keep it
cp 1_coordinates_ORCA_R12.nc $DOMAIN/coordinates.nc

cd $WORK
