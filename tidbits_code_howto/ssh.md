### set up ssh
```bash
sudo apt install openssh-server
sudo mkdir /etc/ssh/default_keys
sudo mv /etc/ssh/ssh_host_* /etc/ssh/default_keys/
sudo dpkg-reconfigure openssh-server
dpkg-reconfigure openssh-server
sudo vim /etc/ssh/sshd_config
```

### If you only need to temporarily start up the SSH service it’s recommended to use ssh.socket:
```bash
systemctl start ssh.socket
```
### When finished:
```bash
systemctl stop ssh.socket
```
### To instead permanently enable the SSH service to start whenever the system is booted use:
```bash
systemctl enable ssh.service
```
### Then to use SSH immediately without having to reboot use:
```bash
systemctl start ssh.service
```
### To check the status of the service you can use:
```bash
systemctl status ssh.service
```
### To stop the SSH service use:
```bash
systemctl stop ssh.service
```
### And to disable the SSH service so it no longer starts at boot:
```bash
systemctl disable ssh.service
```
