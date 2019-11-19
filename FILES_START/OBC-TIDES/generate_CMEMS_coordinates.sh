export CONFIG=SEAsia_CMEMS
export WORK=/projectsa/accord
export CMEMS=$WORK/$CONFIG/CMEMS

# An option is to get the coordinates and mask for CMEMS and then cat them and rename some variables: ATTENTIONS this may be problematic as you get a mask file that has some inconcistencies with the fields particularly with U and V that leads to some problems with pynemo
#get the global coordinate files
#wget ftp://username:***@nrt.cmems-du.eu/Core/GLOBAL_ANALYSIS_FORECAST_PHY_001_024/global-analysis-forecast-phy-001-024-statics/GLO-MFC_001_024_coordinates.nc
#wget ftp://username:***@nrt.cmems-du.eu/Core/GLOBAL_ANALYSIS_FORECAST_PHY_001_024/global-analysis-forecast-phy-001-024-statics/GLO-MFC_001_024_mask_bathy.nc


# Alternative method create our own coordinates and mask files from the fields: this ensures consistency
#create coordinates that corresponds to the new fields
module load nco/gcc/4.4.2.ncwa
ncks -v longitude,latitude,depth,time 2017/CMEMS_2017_01_01_download.nc  tmp1.nc
ncrename -d time,t -d latitude,y -d longitude,x tmp1.nc
ncap2 -O -s 'glamt[t,y,x]=longitude' tmp1.nc
ncap2 -O -s 'glamu[t,y,x]=longitude' tmp1.nc
ncap2 -O -s 'glamv[t,y,x]=longitude' tmp1.nc
ncap2 -O -s 'gphit[t,y,x]=latitude' tmp1.nc 
ncap2 -O -s 'gphiu[t,y,x]=latitude' tmp1.nc
ncap2 -O -s 'gphiv[t,y,x]=latitude' tmp1.nc 
mv tmp1.nc CMEMS_subdomain_coordinates.nc

#create masks that corresponds to the new field
module load nco/gcc/4.4.2.ncwa
ncks -v longitude,latitude,depth,time,so 2017/CMEMS_2017_01_01_download.nc tmp2.nc
ncks -A -v uo,vo 2017/CMEMS_2017_01_01_download_UV.nc tmp2.nc
ncatted -a _FillValue,,d,, tmp2.nc
ncap2 -O -s 'where(so>0.) so=1' tmp2.nc tmp2.nc
ncap2 -O -s 'where(so<=0.) so=0' tmp2.nc tmp2.nc
ncap2 -O -s 'where(uo>-10.) uo=1' tmp2.nc tmp2.nc
ncap2 -O -s 'where(uo<=-10.) uo=0' tmp2.nc tmp2.nc
ncap2 -O -s 'where(vo>-10.) vo=1' tmp2.nc tmp2.nc
ncap2 -O -s 'where(vo<=-10.) vo=0' tmp2.nc tmp2.nc
ncrename -d time,t -d latitude,y -d longitude,x tmp2.nc
ncrename -v so,tmask tmp2.nc
ncrename -v uo,umask tmp2.nc
ncrename -v vo,vmask tmp2.nc
mv tmp2.nc CMEMS_subdomain_mask.nc


