#!/usr/bin/bash

parted /dev/sda mklabel msdos 
parted /dev/sda mkpart primary ext4 1MiB 100MiB
parted /dev/sda mkpart primary ext4 100MiB 8GiB
parted /dev/sda mkpart primary ext4 8GiB 100%
mkfs.ext4 /dev/sda1
mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/sda3


mount /dev/sda2 /mnt

mkdir -p /mnt/home /mnt/boot

mount /dev/sda1 /mnt/boot
mount /dev/sda3 /mnt/home

pacstrap -i /mnt base base-devel grub

genfstab -U /mnt > /mnt/etc/fstab

curl https://raw.githubusercontent.com/vmsynkov/dotfiles/install/init2.sh > /mnt/init2.sh && chmod +x /mnt/init2.sh

arch-chroot /mnt ./init2.sh

umount -R /mnt

reboot
