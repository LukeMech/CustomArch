#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="LukeMechArch"
iso_label="LukeMechArch"
iso_publisher="LukeMech <https://LukeMech.github.io>"
iso_application="LukeMechArch Live CD"
iso_version="$(date +%y.%m)"
install_dir="arch"
buildmodes=('iso')
bootmodes=('uefi-x64.systemd-boot.esp')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="erofs"
airootfs_image_tool_options=('-zlzma,9' -E ztailpacking)
file_permissions=(
  ["/etc/shadow"]="0:0:400"
)
