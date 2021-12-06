#!/bin/bash

#starting snap process
sudo systemctl enable --now snapd.socket

#just for checking
#sudo systemctl is-active snapd.socket
#sudo systemctl is-enabled snapd.socket