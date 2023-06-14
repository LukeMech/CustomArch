#!/usr/bin/env bash
set -e

# Install required dependencies
echo "=> [INFO] Installing git, wget and base-devel..."
pacman -Syu git wget base-devel --noconfirm --needed

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

# Emojis
runuser -u maketmp -- git clone https://aur.archlinux.org/ttf-twemoji
cd ttf-twemoji
runuser -u maketmp -- makepkg -s --noconfirm
cp *.pkg.tar.zst /repo
cd ..

# Gdm plymouth
runuser -u maketmp -- git clone https://aur.archlinux.org/gdm-plymouth-nox
cd gdm-plymouth-nox
runuser -u maketmp -- makepkg -s --noconfirm
cp *.pkg.tar.zst /repo
cd ..

# Aur packages - add to repo
echo "=> [INFO] Creating local repo..."
repo-add /repo/aur-local.db.tar.gz /repo/*