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
cp $GITCLONE/IC/make.macro make.macro
# !!ATTENTION!! inside make.macro change the directory to install into 
# (where username is your username): INSTALL_DIR = /home/n01/n01/username/local

make
make install

