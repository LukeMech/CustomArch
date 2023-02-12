#!/usr/bin/env bash
set -e

# Install required dependencies
echo "=> [INFO] Innstalling git and base-devel..."
pacman -Syu git base-devel --noconfirm --needed

# Create temp user and working dir
echo "=> [INFO] Creating temp user and dirs..."
rm -rf /repo &>/dev/null || true
mkdir /repo
userdel -r maketmp &>/dev/null || true
rm -rf /workingDir &>/dev/null || true
useradd -m -d /workingDir maketmp 
echo "maketmp ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
runuser -u maketmp -- mkdir /workingDir/archFiles
runuser -u maketmp -- mkdir /workingDir/aurPackages
runuser -u maketmp -- cp -r ./archFiles/* /workingDir/archFiles/
cd /workingDir/aurPackages

# Aur packages - clone, make
echo "=> [INFO] Cloning and building packages..."

PACKAGES="
archlinux-appstream-data-pamac
libpamac-nosnap
pamac-nosnap

plymouth
gdm-plymouth
"

for p in $PACKAGES
do  
    runuser -u maketmp -- git clone "https://aur.archlinux.org/$p"
    cd "$p"
    echo "=> [INFO] $p will be (temporarily) installed!"
    runuser -u maketmp -- makepkg -si --noconfirm
    cp *.pkg.tar.zst /repo
    cd ..
done

# Aur packages - add to repo
echo "=> [INFO] Creating local repo..."
repo-add /repo/aur-local.db.tar.gz /repo/*