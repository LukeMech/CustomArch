#!/usr/bin/env bash
set -e

# Install required dependencies
echo "=> [INFO] Innstalling git and base-devel..."
pacman -Syu git base-devel --noconfirm

# Create temp user and working dir
echo "=> [INFO] Creating temp user and dirs..."
mkdir /repo
useradd -m -d /workingDir maketmp
echo "maketmp ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
runuser -u maketmp -- mkdir /workingDir/archFiles
runuser -u maketmp -- mkdir /workingDir/aurPackages
runuser -u maketmp -- cp -r ./archFiles/* /workingDir/archFiles/
cd /workingDir/aurPackages

# Aur packages - clone, make
echo "=> [INFO] Cloning and building packages..."

# Yay
runuser -u maketmp -- git clone https://aur.archlinux.org/yay
cd yay
runuser -u maketmp -- makepkg -s --noconfirm
cp *.pkg.tar.zst /repo
cd ..

# Plymouth
runuser -u maketmp -- git clone https://aur.archlinux.org/plymouth
cd plymouth
runuser -u maketmp -- makepkg -si --noconfirm
cp *.pkg.tar.zst /repo
cd ..

# Gnome Display Manager - plymouth
runuser -u maketmp -- git clone https://aur.archlinux.org/gdm-plymouth
cd gdm-plymouth
runuser -u maketmp -- makepkg -s --noconfirm
cp *.pkg.tar.zst /repo
cd ..

# Aur packages - add to repo
echo "=> [INFO] Creating local repo..."
repo-add /repo/aur-local.db.tar.gz /repo/*