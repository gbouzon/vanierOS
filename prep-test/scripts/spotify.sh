#!/bin/bash

#installing snaps and starting process
#make sure snaps are installed -> add to startup
chmod 755 start_snap_process.sh
./start_snap_process.sh

snap run spotify
