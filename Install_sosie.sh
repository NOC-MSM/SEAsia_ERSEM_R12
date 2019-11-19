cd ~
mkdir local
mkdir sosie
#attention use 2.6 version or 3.0 version
#namelist has to modified accordingly
#git clone -b 2.6 https://github.com/brodeau/sosie.git 
git clone https://github.com/brodeau/sosie.git
cd sosie

# you may need to edit the path in this file
# to add the directory to install binaries
cp $GITCLONE/FILES_START/IC/make.macro make.macro

make
make install

