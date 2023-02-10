#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="LukeMechArch"
iso_label="LukeMechArch"
iso_publisher="LukeMech <https://LukeMech.github.io>"
iso_application="LukeMechArch Live CD"
iso_version="$(date +%y.%m.%d))"
install_dir="arch"
buildmodes=('iso')
bootmodes=('uefi-x64.systemd-boot.esp')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/etc/gshadow"]="0:0:400"
  ["/home/livecd"]="0:0:750"
)
