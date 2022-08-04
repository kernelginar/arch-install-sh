clear

# edit /etc/pacman.conf file
nano /etc/pacman.conf

clear

# timezone
echo 'Example: Europe/Istanbul, Europe/Zurich, America/New_York'
read -p 'Timezone: ' time_zone
ln -sf /usr/share/zoneinfo/$time_zone /etc/localtime
hwclock --systohc

clear

# locale
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
locale-gen

touch /etc/locale.conf
echo 'LANG=en_US.UTF-8' >> /etc/locale.conf

clear

# host
read -p 'hostname: ' host_name
echo $host_name >> /etc/hostname

echo '127.0.0.1       localhost' >> /etc/hosts
echo '::1             localhost' >> /etc/hosts
echo '127.0.1.1       '$host_name'.localdomain     '$host_name >> /etc/hosts

clear

# root password
echo 'Root password'
passwd

# packages
pacman -Sy networkmanager
systemctl enable NetworkManager
sleep 2
clear

# touchpad support
pacman -S xf86-input-libinput
clear

# NTFS filesystem support
pacman -S ntfs-3g
clear

# GRUB
pacman -S grub efibootmgr os-prober
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id='Arch Linux'
grub-mkconfig -o /boot/grub/grub.cfg
sleep 3
clear

# useradd
read -p 'Username: ' user_name
useradd -m -g users -G wheel,storage,power,audio,video,network -s /bin/bash $user_name
echo $user_name 'password'
passwd $user_name

# sudo privileges
EDITOR=nano visudo
clear
