pacman -Syu archiso git base-devel --noconfirm
mkdir /repo

useradd maketmp
git clone https://aur.archlinux.org/yay-bin
cd yay-bin 
runuser -u maketmp -- makepkg -s
cp *.pkg.tar.zst /repo

git clone https://aur.archlinux.org/plymouth
cd plymouth
runuser -u maketmp -- makepkg -s
cp *.pkg.tar.zst /repo

git clone https://aur.archlinux.org/gdm-plymouth
cd gdm-plymouth
runuser -u maketmp -- makepkg -s
cp *.pkg.tar.zst /repo

userdel maketmp

repo-add /repo/custom.db.tar.gz /repo/*
mkarchiso -v -w /archiso -o /build ./archFiles
