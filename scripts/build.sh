#!/usr/bin/env bash
set -e

# Install required dependencies
echo "=> [INFO] Installing archiso..."
pacman -Syu archiso --noconfirm

# Make ISO
echo "=> [INFO] Building image using archiso..."
mkarchiso -v -w /archisotemp -o /lukeMechArch /workingDir/archFiles