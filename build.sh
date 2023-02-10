#!/usr/bin/env bash

pacman -Syu git base-devel archiso --noconfirm

# Create temp user and working dir
mkdir /repo
useradd -m -d /workingDir maketmp
echo "maketmp ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
runuser -u maketmp -- mkdir /workingDir/archFiles
runuser -u maketmp -- mkdir /workingDir/aurPackages
runuser -u maketmp -- cp -r ./archFiles/* /workingDir/archFiles/*
cd /workingDir/aurPackages

# Aur packages clone, makepkg and add to repo
runuser -u maketmp -- git clone https://aur.archlinux.org/yay-bin
cd yay-bin 
runuser -u maketmp -- makepkg -si --noconfirm
cp *.pkg.tar.zst /repo

runuser -u maketmp -- git clone https://aur.archlinux.org/plymouth
cd plymouth
runuser -u maketmp -- makepkg -si --noconfirm
cp *.pkg.tar.zst /repo

runuser -u maketmp -- git clone https://aur.archlinux.org/gdm-plymouth
cd gdm-plymouth
runuser -u maketmp -- makepkg -si --noconfirm
cp *.pkg.tar.zst /repo

repo-add /repo/custom.db.tar.gz /repo/*

# Make iso
mkarchiso -v -w /archiso -o /lukeMechArch /workingDir/archFiles

# Delete temp user and dirs
rm -rf /repo
userdel -r maketmp