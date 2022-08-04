#!/bin/sh
clear

# update mirrors
pacman -Sy archlinux-keyring

clear

# disk configuration
lsblk
echo ' '
read -p 'Select Disk: ' disk_selection
cfdisk $disk_selection

clear
lsblk
echo ' '

# format disk label
read -p 'Root partition with /dev, /dev/???: ' root_partition
mkfs.ext4 $root_partition
mount $root_partition /mnt

read -p 'Boot partition with /dev, /dev/???: ' boot_partition
mkfs.fat -F32 $boot_partition
mkdir -p /mnt/boot/efi

clear

# install base packages
pacstrap /mnt base base-devel linux linux-headers linux-firmware git nano

# create fstab file
genfstab -U /mnt > /mnt/etc/fstab
mount $boot_partition /mnt/boot/efi

cp $(pwd)/chroot.sh /mnt
arch-chroot /mnt /bin/bash
rm -rf /mnt/chroot.sh
