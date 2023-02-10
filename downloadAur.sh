#!/usr/bin/env bash

pacman -Syu git base-devel --noconfirm
mkdir /repo

# Aur packages clone, makepkg and add to repo
useradd -m -d /maketmp maketmp
echo "maketmp ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
cd /maketmp

runuser -u maketmp -- git clone https://aur.archlinux.org/yay-bin
cd yay-bin 
runuser -u maketmp -- makepkg -s --noconfirm
cp *.pkg.tar.zst /repo

runuser -u maketmp -- git clone https://aur.archlinux.org/plymouth
cd plymouth
runuser -u maketmp -- makepkg -s --noconfirm
cp *.pkg.tar.zst /repo

runuser -u maketmp -- git clone https://aur.archlinux.org/gdm-plymouth
cd gdm-plymouth
runuser -u maketmp -- makepkg -s --noconfirm
cp *.pkg.tar.zst /repo

userdel maketmp

repo-add /repo/custom.db.tar.gz /repo/*