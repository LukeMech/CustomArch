#!/usr/bin/env bash
BASEDIR=$(dirname "$0")

pacman -Syu archiso git base-devel --noconfirm
mkdir /repo

# Aur packages clone, makepkg and add to repo
useradd -m -d /maketmp maketmp
echo "maketmp ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
cd /maketmp

runuser -u maketmp -- git clone https://aur.archlinux.org/yay-bin
cd yay-bin 
runuser -u maketmp -- makepkg -s
cp *.pkg.tar.zst /repo

runuser -u maketmp -- git clone https://aur.archlinux.org/plymouth
cd plymouth
runuser -u maketmp -- makepkg -s
cp *.pkg.tar.zst /repo

runuser -u maketmp -- git clone https://aur.archlinux.org/gdm-plymouth
cd gdm-plymouth
runuser -u maketmp -- makepkg -s
cp *.pkg.tar.zst /repo

userdel maketmp

repo-add /repo/custom.db.tar.gz /repo/*