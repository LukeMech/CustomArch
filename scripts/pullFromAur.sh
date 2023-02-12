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

# # Aur packages - clone, make
# echo "=> [INFO] Cloning and building packages..."

# # Pamac
# runuser -u maketmp -- git clone https://aur.archlinux.org/archlinux-appstream-data-pamac
# cd archlinux-appstream-data-pamac
# runuser -u maketmp -- makepkg -si --noconfirm
# cp *.pkg.tar.zst /repo
# cd ..
# runuser -u maketmp -- git clone https://aur.archlinux.org/libpamac-nosnap
# cd libpamac-nosnap
# runuser -u maketmp -- makepkg -si --noconfirm
# cp *.pkg.tar.zst /repo
# cd ..
# runuser -u maketmp -- git clone https://aur.archlinux.org/pamac-nosnap
# cd pamac-nosnap
# runuser -u maketmp -- makepkg -s --noconfirm
# cp *.pkg.tar.zst /repo
# cd ..

# # Plymouth
# runuser -u maketmp -- git clone https://aur.archlinux.org/plymouth
# cd plymouth
# runuser -u maketmp -- makepkg -si --noconfirm
# cp *.pkg.tar.zst /repo
# cd ..
# runuser -u maketmp -- git clone https://aur.archlinux.org/gdm-plymouth
# cd gdm-plymouth
# runuser -u maketmp -- makepkg -s --noconfirm
# cp *.pkg.tar.zst /repo
# cd ..

# # Aur packages - add to repo
# echo "=> [INFO] Creating local repo..."
# repo-add /repo/aur-local.db.tar.gz /repo/*
