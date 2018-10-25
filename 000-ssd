#!/bin/bash
set -e

echo "### enabling TRIM ####"

sudo systemctl enable fstrim.timer

echo "### TRIM enabled ####"

echo -e "\n/dev/sdb1 /run/media/chema/Data ntfs-3g defaults 0 0" | sudo tee -a /etc/fstab

echo -e "\nCacheDir    = /run/media/chema/Data/VARIOS/pacman/pkg/" | sudo tee -a /etc/pacman.conf

echo "### pacman cache folder moved to DATA ###"

echo "### please restart computer ###"