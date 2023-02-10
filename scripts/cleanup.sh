# Delete temp user, dirs and cleanup packages
set -e

read -p '=> [QUESTION] Delete temporary user and build files? [Y/n] ' deleteuser
if [ "$deleteuser" = 'n' ]; then echo "Not deleting."; else echo "Deleting 'maketmp' user and '/workingDir' path..." && userdel -r maketmp; fi

read -p '=> [QUESTION] Delete temporary repo with aur packages? [Y/n] ' deleterepo
if [ "$deleterepo" = 'n' ]; then echo "Not deleting."; else echo "Deleting '/repo'..." && rm -rf /repo; fi

read -p '=> [QUESTION] Uninstall archiso? (No longer required for build) [Y/n] ' uninstallarchiso
if [ "$uninstallarchiso" = 'n' ]; then echo "Not removing."; else pacman -Rns archiso --noconfirm; fi

read -p '=> [QUESTION] Uninstall plymouth? (No longer required for build) [y/N] ' uninstallplymouth
if [ "$uninstallplymouth" = 'y' ]; then pacman -Rns plymouth --noconfirm; else echo "Not removing."; fi

read -p '=> [QUESTION] Uninstall git? (No longer required for build) [y/N] ' uninstallgit
if [ "$uninstallgit" = 'y' ]; then pacman -Rns git --noconfirm; else echo "Not removing."; fi

echo "=> [INFO] Removing unneeded packages..."
pacman -Qdtq | pacman -Rns - --noconfirm