pacman -Syu archiso git base-devel --noconfirm

mkdir /repo

git clone https://aur.archlinux.org/yay-bin
cd yay-bin
makepkg -s --asroot
cp *.pkg.tar.zst /repo
cd ..
rm -rf yay-bin 

git clone https://aur.archlinux.org/plymouth
cd plymouth
makepkg -s --asroot
cp *.pkg.tar.zst /repo
cd ..
rm -rf plymouth

git clone https://aur.archlinux.org/gdm-plymouth
cd gdm-plymouth
makepkg -s --asroot
cp *.pkg.tar.zst /repo
cd ..
rm -rf gdm-plymouth

repo-add /repo/custom.db.tar.gz /repo/*
mkarchiso -v -w /archiso -o /build /home/root/archFiles
