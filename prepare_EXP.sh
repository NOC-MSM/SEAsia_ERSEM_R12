cd $EXP

# copy files (namelist etc.)
cp $GITCLONE/FILES_START/EXP_TEST/* ./

#copy the opa executable and xios 
cp $XIOS_DIR/bin/xios_server.exe ./
cp $CDIR/$CONFIG/BLD/bin/nemo.exe opa

#copy domain 
cp $DOMAIN/domain_cfg_gebco.nc ./

cd $WORK
