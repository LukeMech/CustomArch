pacman -Syu archiso git --noconfirm

mkdir /repo
useradd -m aur-temp

runuser -l aur-temp -c git clone https://aur.archlinux.org/yay-bin
cd yay-bin
source PKGBUILD && pacman -Syu --noconfirm --needed --asdeps "${makedepends[@]}" "${depends[@]}"
runuser -l aur-temp -c makepkg
cp *.pkg.tar.zst /repo
cd ..
rm -rf yay-bin 

runuser -l aur-temp -c git clone https://aur.archlinux.org/plymouth
cd plymouth
source PKGBUILD && pacman -Syu --noconfirm --needed --asdeps "${makedepends[@]}" "${depends[@]}
runuser -l aur-temp -c makepkg
cp *.pkg.tar.zst /repo
cd ..
rm -rf plymouth

runuser -l aur-temp -c git clone https://aur.archlinux.org/gdm-plymouth
cd gdm-plymouth
source PKGBUILD && pacman -Syu --noconfirm --needed --asdeps "${makedepends[@]}" "${depends[@]}
runuser -l aur-temp -c makepkg
cp *.pkg.tar.zst /repo
cd ..
rm -rf gdm-plymouth

repo-add /repo/custom.db.tar.gz /repo/*
mkarchiso -v -w /archiso -o /build archFiles
