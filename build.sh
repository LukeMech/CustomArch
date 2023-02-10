#!/usr/bin/env bash

# Start config
set -e
if pacman -Qi archiso &>/dev/null; then ArchisoInstalled=1; else ArchisoInstalled=0; fi
if pacman -Qi git &>/dev/null; then GitInstalled=1; else GitInstalled=0; fi
pacman -Syu git base-devel archiso --noconfirm

# Create temp user and working dir
mkdir /repo
useradd -m -d /workingDir maketmp
echo "maketmp ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
runuser -u maketmp -- mkdir /workingDir/archFiles
runuser -u maketmp -- mkdir /workingDir/aurPackages
runuser -u maketmp -- cp -r ./archFiles/* /workingDir/archFiles/
cd /workingDir/aurPackages

# Aur packages clone, makepkg and add to repo

# Yay
runuser -u maketmp -- git clone https://aur.archlinux.org/yay
cd yay
runuser -u maketmp -- makepkg -s --noconfirm
cp *.pkg.tar.zst /repo
cd ..

# Plymouth
if pacman -Qi plymouth &>/dev/null; then PlymouthInstalled=1; else PlymouthInstalled=0; fi
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

repo-add /repo/aur-local.db.tar.gz /repo/*

# Make ISO
mkarchiso -v -w /archiso -o /lukeMechArch /workingDir/archFiles

# Delete temp user, dirs and cleanup packages
rm -rf /repo &>/dev/null
userdel -r maketmp &>/dev/null
if [ $ArchisoInstalled -eq 0 ]; then pacman -Rns archiso --noconfirm; fi
if [ $GitInstalled -eq 0 ]; then pacman -Rns git --noconfirm; fi
if [ $PlymouthInstalled -eq 0 ]; then pacman -Rns plymouth --noconfirm; fi
pacman -Qdtq | pacman -Rns - --noconfirm