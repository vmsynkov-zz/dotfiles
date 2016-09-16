echo en_US.UTF-8 UTF-8 > /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf

ln -sf /usr/share/zoneinfo/Europe/Kiev /etc/localtime
hwclock --systohc --utc

mkinitcpio -p linux

grub-install --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

echo archie > /etc/hostname

printf "127.0.0.1\tlocalhost.localdomain\tlocalhost\tarchie\n::1\t\tlocalhost.localdomain\tlocalhost\tarchie" > /etc/hosts

systemctl enable dhcpcd@enp0s3.service

groupadd -g 1993 skult

useradd -m -g 1993 -u 1304 cli3mo

echo "root:j" | chpasswd
echo "cli3mo:j" | chpasswd

curl https://raw.githubusercontent.com/vmsynkov/dotfiles/install/install.sh > /home/cli3mo/install.sh
chmod +x /home/cli3mo/install.sh

/home/cli3mo/install.sh vbox
