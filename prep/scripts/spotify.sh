#!/bin/bash

#installing snaps and starting process
chmod 755 snap_software.sh
chmod 755 start_snap_process.sh

./snap_software.sh
./start_snap_process.sh

snap run spotify