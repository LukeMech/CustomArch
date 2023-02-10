#!/usr/bin/env bash

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
if pacman -Qi yay-bin &>/dev/null; then YayInstalled=1; else YayInstalled=0; fi
runuser -u maketmp -- git clone https://aur.archlinux.org/yay-bin
cd yay-bin 
runuser -u maketmp -- makepkg -si --noconfirm
cp *.pkg.tar.zst /repo

if pacman -Qi yay-bin &>/dev/null; then PlymouthInstalled=1; else PlymouthInstalled=0; fi
runuser -u maketmp -- git clone https://aur.archlinux.org/plymouth
cd plymouth
runuser -u maketmp -- makepkg -si --noconfirm
cp *.pkg.tar.zst /repo

if pacman -Qi libgdm-plymouth &>/dev/null; then GDMPlymouthInstalled=1; else GDMPlymouthInstalled=0; fi
runuser -u maketmp -- git clone https://aur.archlinux.org/gdm-plymouth
cd gdm-plymouth
runuser -u maketmp -- makepkg -si --noconfirm
cp *.pkg.tar.zst /repo

repo-add /repo/custom.db.tar.gz /repo/*

if [ $YayInstalled -eq 0 ]; then pacman -Rsnc yay-bin --noconfirm; fi
if [ $PlymouthInstalled -eq 0 ]; then pacman -Rsnc plymouth --noconfirm; fi
if [ $GDMPlymouthInstalled -eq 0 ]; then pacman -Rsnc gdm-plymouth --noconfirm; fi

# Make ISO
mkarchiso -v -w /archiso -o /lukeMechArch /workingDir/archFiles

# Delete temp user and dirs
rm -rf /repo &>/dev/null
userdel -r maketmp &>/dev/null