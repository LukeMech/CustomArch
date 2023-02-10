#!/usr/bin/env bash
set -e

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
runuser -u maketmp -- git clone https://aur.archlinux.org/yay
cd yay
runuser -u maketmp -- makepkg -s --noconfirm
cp *.pkg.tar.zst /repo
cd ..

if pacman -Qi plymouth &>/dev/null; then PlymouthInstalled=1; else PlymouthInstalled=0; fi
runuser -u maketmp -- git clone https://aur.archlinux.org/plymouth
cd plymouth
runuser -u maketmp -- makepkg -si --noconfirm
cp *.pkg.tar.zst /repo
cd ..

runuser -u maketmp -- git clone https://aur.archlinux.org/gdm-plymouth
cd gdm-plymouth
runuser -u maketmp -- makepkg -s --noconfirm
cp *.pkg.tar.zst /repo
cd ..

repo-add /repo/aur-local.db.tar.gz /repo/*

if [ $PlymouthInstalled -eq 0 ]; then pacman -Rns plymouth --noconfirm; fi
pacman -Qdtq | pacman -Rns - --noconfirm

# Make ISO
mkarchiso -v -w /archiso -o /lukeMechArch /workingDir/archFiles

# Delete temp user and dirs
rm -rf /repo &>/dev/null
userdel -r maketmp &>/dev/null