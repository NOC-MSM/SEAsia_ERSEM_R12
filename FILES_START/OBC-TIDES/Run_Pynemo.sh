#run pynemo

#load modules
module load anaconda/2.1.0  # Want python2
source activate nrct_env
export LD_LIBRARY_PATH=/usr/lib/jvm/jre-1.7.0-openjdk.x86_64/lib/amd64/server:$LD_LIBRARY_PATH

#echo "Running Pynemo"
pynemo -s namelist_2018.bdy > T2018_pynemo.txt 2>&1
