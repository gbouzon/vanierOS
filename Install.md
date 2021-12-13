Preparation for install a live system
--------------------------------------

Step 1
Install the live-build tool(this step need to be run with "sudo"): 

# apt-get install live-build 
--------------------------------------

Step 2
Create a prep directory in home folder. Naming it differently will require customizing the instructions.

# mkdir prep

--------------------------------------

Step 3
Collect all background images, especially the current background, and copy them to a folder inside /prep.

# cp -r backgrounds /prep/backgrounds

--------------------------------------

Step 4
Configure your desktop settings exactly the way you want to preserve them for the live system. 
If using XFCE, all of these settings are stored in ~/.config/xfce4. Copy that folder inside /prep. 

# cp -r ~/.config/xfce4 ~/prep/

--------------------------------------

Step 5 (optional)
Copy other deb packages into the /prep/misc64 folder if you have

--------------------------------------

Step 6 (optional)
If you have any shell scripts, place them in the /prep/scripts folder. If you have any icons, place them in the /prep/icons folder. If you have any hooks, place them in the /prep/hooks folder. If you have any documentation, place the it in the /prep/doc folder. 

--------------------------------------

Step 7
The /bootloaders directory is found in /usr/share/live/build/ - copy the folder into your /prep/ directory.
# cp -r /usr/share/live/build/bootloaders /prep/bootloaders

Inside each of the subfolders within /bootloaders is a file named: splash.svg or splash.png. These are default images and can be replaced. Use whatever graphic program you like to create or edit an image for use as your boot splash. Any text you place on the image should be in the upper portion of the image - the lower half will display the boot menu. When you are satified with your image, save it as a 640x480 pixel PNG graphic file named splash.png. Copy the file into each of the subfolders of /bootloaders with the exception of the grub-legacy folder. Grub-legacy will probably never be used, but if you want to replace that image, save a copy of your splash image as a 640x480 pixel XPM graphic file and name it splash.xpm. You will need to gzip the splash.xpm file and replace the default file in the grub-legacy subfolder.

--------------------------------------


# prepare-howto.txt -- Revision: 111r1 -- by eznix (https://sourceforge.net/projects/eznixos/)
# (GNU/General Public License version 3.0)

Now start to build the live system
Step by Step Live-Build - AMD64 Architecture Example

-----------------------------------

Suggested location for the build staging folder:

  /vanierOS -- build folder

Suggested location for the collection of preparation files and packages:

  /prep  -- files location


The build procedure begins below. Copy and paste each command exactly unless you know what you are doing and are comfortable making changes.
ALL COMMANDS NEED TO BE RUN AS ROOT! su -l 

----------------------------------

Step 1: Assign the variable WKDIR the output of pwd

# Run command below to set the working directory:

WKDIR="$(pwd)" -> echo $WKDIR should result in /root

create prep and vanierOS (build) folders in /root directory for the rest of these commands to work

----------------------------------

Step 2: Remove the icon cache cleaning hook, create the build staging folder, and cd into it

# Run commands below to prepare for the build:

[[ -f /usr/share/live/build/hooks/normal/0130-remove-gnome-icon-cache.hook.chroot ]] && rm /usr/share/live/build/hooks/normal/0130-remove-gnome-icon-cache.hook.chroot
mkdir vanierOS
cd vanierOS

----------------------------------

Step 3: Set up the live-build config

# Run command below to configure live build:

lb config --binary-images iso-hybrid --mode debian --architectures amd64 --linux-flavours amd64 --distribution bullseye --archive-areas "main contrib non-free" --updates true --security true --cache true --apt-recommends true --debian-installer live --debian-installer-gui true --win32-loader false --iso-application vanierOS --iso-preparer vanierfloss-https://github.com/gbouzon/vanierOS --iso-publisher vanierfloss-https://github.com/gbouzon/vanierOS --iso-volume vanierOS

# If the Debian Installer does not work, try inserting 	--debian-installer-distribution daily into the lb config options

----------------------------------

Step 4: Pass the desktop and packages to the live-build config

# Run command below to install the Xfce Desktop:

echo task-xfce-desktop > $WKDIR/vanierOS/config/package-lists/desktop.list.chroot

# Run command below to install tons of software (You can modify and download the software you want):
# If the software cannot download directly, you can write another scripts then put them in scripts folder

echo "haveged less gdebi galculator grsync synaptic gparted bleachbit flac faad faac mjpegtools x265 x264 mpg321 ffmpeg streamripper sox mencoder dvdauthor twolame lame asunder aisleriot dosbox filezilla libxvidcore4 vlc soundconverter hplip-gui cdrdao frei0r-plugins htop jfsutils xfsprogs ntfs-3g cdtool mtools clonezilla testdisk numix-gtk-theme greybird-gtk-theme breeze-icon-theme breeze-gtk-theme xorriso cdrskin p7zip-full p7zip-rar hardinfo inxi gnome-disk-utility simplescreenrecorder thunderbird simple-scan gthumb remmina arc-theme gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-plugins-good gnome-system-tools dos2unix dialog papirus-icon-theme transmission-gtk rar unrar cifs-utils fuse3 gvfs-fuse gvfs-backends gvfs-bin pciutils squashfs-tools syslinux syslinux-common dosfstools isolinux live-build fakeroot linux-headers-amd64 lsb-release menu build-essential dkms curl wget iftop apt-transport-https dirmngr nvidia-detect openvpn network-manager-openvpn openvpn-systemd-resolved libqt5opengl5 neofetch firmware-linux firmware-linux-nonfree firmware-misc-nonfree firmware-realtek firmware-atheros firmware-bnx2 firmware-bnx2x firmware-brcm80211 firmware-ipw2x00 firmware-intelwimax firmware-iwlwifi firmware-libertas firmware-netxen firmware-zd1211 gnome-nettool guvcview snapd git libreoffice vim plank" > $WKDIR/vanierOS/config/package-lists/packages.list.chroot

# Run command below to install EFI boot loader packages:

echo "grub-common grub2-common grub-pc-bin efibootmgr grub-efi-amd64 grub-efi-amd64-bin grub-efi-amd64-signed grub-efi-ia32-bin libefiboot1 libefivar1 mokutil shim-helpers-amd64-signed shim-signed-common shim-unsigned" > $WKDIR/vanierOS/config/package-lists/grubuefi.list.binary

# Run command below to include Broadcom wireless drivers:

echo "b43-fwcutter firmware-b43-installer firmware-b43legacy-installer" > $WKDIR/vanierOS/config/package-lists/wifidrivers.list.chroot

----------------------------------

Step 5: Make folders in the chroot 

# Run command below to create needed folders:

mkdir -p $WKDIR/vanierOS/config/includes.chroot/usr/share/vanierOS
mkdir -p $WKDIR/vanierOS/config/includes.chroot/etc/skel/.config
mkdir -p $WKDIR/vanierOS/config/includes.chroot/usr/share/backgrounds
mkdir -p $WKDIR/vanierOS/config/includes.chroot/usr/share/icons/default
mkdir -p $WKDIR/vanierOS/config/includes.chroot/usr/local/bin
mkdir -p $WKDIR/vanierOS/config/includes.chroot/usr/share/applications
mkdir -p $WKDIR/vanierOS/config/includes.chroot/usr/share/doc/vanierOS
mkdir -p $WKDIR/vanierOS/config/includes.chroot/etc/skel/Desktop -> skel "skeleton" refers to user folders
mkdir -p $WKDIR/vanierOS/config/includes.chroot/etc/live/Desktop -> live here refers to when user chooses the live system option instead of graphical installer

-----------------------------------

Step 6: Copy files into the chroot and live-build config

# Run commands below to copy build files into the live system:

cp -r $WKDIR/prep $WKDIR/vanierOS/config/includes.chroot/usr/share/vanierOS/
cp -r $WKDIR/prep/bootloaders $WKDIR/vanierOS/config/
cp -r $WKDIR/prep/xfce4 $WKDIR/vanierOS/config/includes.chroot/etc/skel/.config/
cp $WKDIR/prep/scripts/* $WKDIR/vanierOS/config/includes.chroot/usr/local/bin/
cp $WKDIR/prep/doc/* $WKDIR/vanierOS/config/includes.chroot/usr/share/doc/vanierOS/
cp $WKDIR/prep/backgrounds/* $WKDIR/vanierOS/config/includes.chroot/usr/share/backgrounds/
cp $WKDIR/prep/icons/* $WKDIR/vanierOS/config/includes.chroot/usr/share/icons/default/
cp $WKDIR/prep/launchers/ezadmin.desktop $WKDIR/vanierOS/config/includes.chroot/usr/share/applications/
ln -s /usr/share/doc/vanierOS $WKDIR/vanierOS/config/includes.chroot/etc/skel/Desktop/

-----------------------------------

# Run command below If you wish to include deb packages from misc64 folder:
# If you don't have other deb packages stored in the /prep/misc64 folder, You can ignore this command
cp $WKDIR/prep/misc64/* $WKDIR/vanierOS/config/packages.chroot/

-----------------------------------

Step 7: Start the build process

# Run command below to start live build: (PLEASE PAY ATTENTION all the command need to be RUN AS ROOT! su -l )
# Otherwise when you run "lb build" command, you cannot get the ISO  

lb build

-----------------------------------

Step 8: Wait for the build to complete. The ISO will be inside the build folder(vanierOS)

-----------------------------------

# bldeznix111-howto.txt -- Revision: 111r1 -- by eznix (https://sourceforge.net/projects/eznixos/)
# (GNU/General Public License version 3.0)