#!/bin/bash

#installing snapd software -> unpack snap packages (??)
#run script as sudo

#install snapd first, just in case not unpacked at build time
sudo apt-get install snapd

#install mysql packages
snap install mysql --beta

#greenfoot packages
snap install greenfoot

#vsc packages
snap install code --classic

snap install spotify

#eclipse packages
snap install eclipse --classic

#android-studio packages
snap install android-studio --classic

#apache netbeans packages
snap install netbeans --classic

#blender packages
snap install blender --classic

#at the end: add software installation for xampp + intel firmware (fail at build, check later)
#unpack snap??????????????????????:::

#start snap process: -> will be converted to another script later (maybe configured with systemd)

#sudo systemctl enable --now snapd.socket
#sudo systemctl is-active snapd.socket
#sudo systemctl is-enabled snapd.socket
#since snaps are already installed make a separate script, add a icon to each one and add it to desktop (make sure they're chmod 755)
#command: snap run <snap name> (e.g. snap run greenfoot)