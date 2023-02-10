pacman -Syu archiso git --noconfirm

mkdir /repo
useradd -m aurtemp
cd /home/aurtemp

runuser -l aurtemp -c "git clone https://aur.archlinux.org/yay-bin"
cd yay-bin
source PKGBUILD && pacman -Syu --noconfirm --needed --asdeps "${makedepends[@]}" "${depends[@]}"
runuser -l aurtemp -c makepkg
cp *.pkg.tar.zst /repo
cd ..
rm -rf yay-bin 

runuser -l aurtemp -c "git clone https://aur.archlinux.org/plymouth"
cd plymouth
source PKGBUILD && pacman -Syu --noconfirm --needed --asdeps "${makedepends[@]}" "${depends[@]}
runuser -l aurtemp -c makepkg
cp *.pkg.tar.zst /repo
cd ..
rm -rf plymouth

runuser -l aurtemp -c "git clone https://aur.archlinux.org/gdm-plymouth"
cd gdm-plymouth
source PKGBUILD && pacman -Syu --noconfirm --needed --asdeps "${makedepends[@]}" "${depends[@]}
runuser -l aurtemp -c makepkg
cp *.pkg.tar.zst /repo
cd ..
rm -rf gdm-plymouth

repo-add /repo/custom.db.tar.gz /repo/*
mkarchiso -v -w /archiso -o /build /home/root/archFiles
