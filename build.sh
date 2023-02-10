pacman -Syu archiso git --noconfirm

mkdir /repo

git clone https://aur.archlinux.org/yay-bin
cd yay-bin
source PKGBUILD && pacman -Syu --noconfirm --needed --asdeps "${makedepends[@]}" "${depends[@]}"
makepkg --asroot
cp *.pkg.tar.zst /repo
cd ..
rm -rf yay-bin 

git clone https://aur.archlinux.org/plymouth
cd plymouth
source PKGBUILD && pacman -Syu --noconfirm --needed --asdeps "${makedepends[@]}" "${depends[@]}
makepkg --asroot
cp *.pkg.tar.zst /repo
cd ..
rm -rf plymouth

git clone https://aur.archlinux.org/gdm-plymouth
cd gdm-plymouth
source PKGBUILD && pacman -Syu --noconfirm --needed --asdeps "${makedepends[@]}" "${depends[@]}
makepkg --asroot
cp *.pkg.tar.zst /repo
cd ..
rm -rf gdm-plymouth

repo-add /repo/custom.db.tar.gz /repo/*
mkarchiso -v -w /archiso -o /build /home/root/archFiles
