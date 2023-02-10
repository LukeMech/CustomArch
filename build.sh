pacman -Syu archiso git base-devel --noconfirm
mkdir /repo

useradd -m -d /maketmp maketmp
runuser -u maketmp -- git clone https://aur.archlinux.org/yay-bin
ls
runuser -u maketmp -- ls
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
mkarchiso -v -w /archiso -o /build ./archFiles
