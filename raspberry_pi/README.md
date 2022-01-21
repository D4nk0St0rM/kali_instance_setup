##### Using raspberry pi as remote tool box

- [Debian](https://wiki.debian.org/RaspberryPi3)
- [Kali](https://www.offensive-security.com/kali-linux-arm-images/)
- [Shell script to build Debian SD card image](https://github.com/emojifreak/debian-rpi-image-script)

##### Set up SSH
```
sudo apt-get install openssh-server
sudo systemctl status ssh
sudo ufw allow ssh
sudo apt-get install ufw
sudo ufw allow ssh
sudo ufw enable
sudo ufw status
```
#### Set up SFTP
```
mkdir -p /data
chmod 701 /data
groupadd sftp_users
sudo groupadd sftp_users
sudo useradd -g sftp_users -d /upload -s /sbin/nologin sftpuser1 
sudo passwd sftpuser1
mkdir /data/sftpuser1/upload
mkdir /data/sftpuser1
mkdir /data/sftpuser1/upload
chown -R root:sftp_users /data/sftpuser1
chown -R sftpuser1:sftp_users /data/sftpuser1/upload
nano /etc/ssh/sshd_config
Match Group sftp_users
ChrootDirectory /data/%u
ForceCommand internal-sftp
###CTRL+C
systemctl restart sshd
```

##### Mount USB storage
```
lsblk
sudo fdisk /dev/sda
Command (m for help): o
Command (m for help): n
Select (default p): 
Using default response p.
Partition number (1-4, default 1): 
Command (m for help): w
sudo fdisk -l /dev/sda
sudo mkfs.ext4 -L PIDRIVE1 /dev/sda1
sudo mkdir /mnt/pidrive1
sudo mount -L PIDRIVE1 /mnt/pidrive1
ls /mnt/pidrive1/
nano /etc/fstab

proc            /proc           proc    defaults          0       0
/dev/mmcblk0p1  /boot           vfat    defaults          0       2
/dev/mmcblk0p2  /               ext4    defaults,noatime  0       1
LABEL=PIDRIVE1  /mnt/pidrive1   ext4    defaults,noatime  0       1
```

##### Setting up Kali on raspberry pi [update etc/apt/sources.list]

```
sudo apt-get install kali-linux-headless
sudo apt install kali-linux-default
```



