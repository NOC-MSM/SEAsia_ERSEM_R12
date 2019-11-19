#run pynemo
export CONFIG=SEAsia_CMEMS
export WORK=/projectsa/accord/$CONFIG
export OBC=$WORK/OPEN_BOUNDARIES_GEMBCO
cd $OBC

#
#load modules
module load anaconda/2.1.0  # Want python2
source activate nrct_env
export LD_LIBRARY_PATH=/usr/lib/jvm/jre-1.7.0-openjdk.x86_64/lib/amd64/server:$LD_LIBRARY_PATH

#create directory for storage of year
cd OUTPUT
mkdir 2018
cd ..

#echo "Running Pynemo"
pynemo -s namelist_2018.bdy > T2018_pynemo.txt 2>&1
#pynemo -s namelist_FES14.bdy > Ttide_pynemo.txt 2>&1

