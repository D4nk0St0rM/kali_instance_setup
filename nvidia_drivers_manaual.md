## Install NVIDIA [470.xx / 465.xx / 460.xx / 390.xx / 340.xx] Drivers on Debian / Ubuntu / Linux Mint / LMDE

[Source: ](https://www.if-not-true-then-false.com/2021/debian-ubuntu-linux-mint-nvidia-guide)

### Set Up
- #### Check is your NVIDIA card supported
```
lspci |grep -E "VGA|3D"
```

- #### Disable UEFI Secure Boot or Check Howto Sign NVIDIA Kernel Module

  - If you have UEFI Secure Boot enabled, then you have to disable Secure Boot or sign your NVIDIA kernel module.

- #### Driver
Go to http://www.nvidia.com/Download/Find.aspx?lang=en-us and find latest version of installer package. 
  
<details><summary>Notes for 340.108 users:</summary>
<p>
340.108 on Debian / Ubuntu / Linux Mint / LMDE Kernel 5.x needs a patched version 
[Download inttf NVIDIA patcher and patch NVIDIA-Linux-x86_64-340.108 for Kernel 5.x](https://www.if-not-true-then-false.com/2020/inttf-nvidia-patcher/)
</p>
</details>

<details><summary>Notes for 418.113 and 435.21 users:</summary>
These are not official NVIDIA LEGACY drivers, but there is example GeForce GTX 1650 Mobile card which is not supported by older or newer drivers. 
[Download inttf NVIDIA patcher and patch NVIDIA-Linux-x86_64-418.113 and NVIDIA-Linux-x86_64-435.21 for Kernel 5.x](https://www.if-not-true-then-false.com/2020/inttf-nvidia-patcher/)
</p>
</details>

### Installation

- #### Make NVIDIA installer executable
```
chmod +x /path/to/NVIDIA-Linux-*.run
```
- #### Change root user
```
su -
## OR ##
sudo -i
```

- ##### Make sure that you system is up-to-date and you are running latest kernel, also make sure that you don’t have any Debian / Ubuntu / Linux Mint / LMDE NVIDIA package installed

- #### Ubuntu / Debian / Linux Mint / LMDE ##
```
apt update

apt upgrade
```
  - #### Debian and Linux Mint
```
apt autoremove $(dpkg -l nvidia-driver* |grep ii |awk '{print $2}')
```
- #### Ubuntu
```
apt autoremove $(dpkg -l xserver-xorg-video-nvidia* |grep ii |awk '{print $2}')

apt reinstall xserver-xorg-video-nouveau
```

> After update and/or NVIDIA drivers remove reboot your system and boot using latest kernel and nouveau:
```
reboot
```

- #### Install needed dependencies

- #### Ubuntu / Debian / Linux Mint
```
apt install linux-headers-$(uname -r) gcc make acpid dkms libglvnd-core-dev libglvnd0 libglvnd-dev dracut
```

- #### Disable nouveau
```
echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf
vim /etc/default/grub

Append ‘rd.driver.blacklist=nouveau’ to end of ‘GRUB_CMDLINE_LINUX=”…”‘.

## Example row on Debian ##
GRUB_CMDLINE_LINUX_DEFAULT="quiet rd.driver.blacklist=nouveau"

## OR with Ubuntu and Linux Mint ##
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash rd.driver.blacklist=nouveau"
```

- #### Update grub2 conf

- #### Ubuntu / Debian / Linux Mint
```
## BIOS and UEFI ##
update-grub2
```
- #### Generate initramfs
```
## Backup old initramfs nouveau image ##
mv /boot/initrd.img-$(uname -r) /boot/initrd.img-$(uname -r)-nouveau
 
## Generate new initramfs image ##
dracut -q /boot/initrd.img-$(uname -r) $(uname -r)
```
- #### Reboot to runlevel 3
Note: You don’t have Desktop/GUI on runlevel 3. Make sure that you have some access to end of guide. (Open it on mobile browser, Print it, use lynx/links/w3m, save it to text file).
```
systemctl set-default multi-user.target

reboot
```
OR alternatively you can change the runlevel on GRUB2 adding one additional parameter. Quick guide howto change runlevel on GRUB2. If you use this method, then don’t set multi-user.target and don’t set graphical.target on step 2.9 (just reboot).
2.8 Install NVIDIA proprietary drivers for GeForce 6/7 & GeForce 8/9/200/300 & GeForce 400/500/600/700/800/900/10/20/30 series cards

- #### Log in as root user
Or alternatively change root user (you shouldn’t have nouveau and xorg loaded)
```
su -
## OR ##
sudo -i
```
- #### Run NVIDIA Binary

Following command executes driver install routine. Use full file name command if you have multiple binaries on same directory.
```
./NVIDIA-Linux-*.run
## OR full path / full file name ##

Downloads/NVIDIA-Linux-x86_64-470.42.01.run
./NVIDIA-Linux-x86_64-435.21-patched-kernel-5.11.run
/path/to/NVIDIA-Linux-x86_64-340.108-patched-kernel-5.11.run
```

- #### All Is Done and Then Reboot Back to Runlevel 5
```
systemctl set-default graphical.target

reboot
```
