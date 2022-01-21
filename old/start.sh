#!/bin/bash

    #### D4nk0St0rM
    #### support not exploit, spread love, share knowledge, help others

## update sources list first: https://github.com/D4nk0St0rM/simple_linux_tweaks/blob/main/sources.list
set -x
rm -r Music/
rm -r Templates/
rm -r Videos/
rm -r Public/
sudo setxkbmap -layout gb
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EB3E94ADBE1229CF
sudo apt-get update -y
sudo apt-file update
sudo apt-get dist-upgrade -y
sudo apt-get install dbus-x11 -y
sudo apt-get install gnome-themes-standard -y
sudo apt-get install kali-linux-large -y
#sudo apt install -y openvpn dialog python3-pip python3-setuptools
wget -q -O - https://repo.protonvpn.com/debian/public_key.asc | sudo apt-key add 
# sudo add-apt-repository 'deb https://repo.protonvpn.com/debian unstable main'
sudo apt-get update && sudo apt-get install protonvpn
sudo apt-get install protonvpn-cli -y
sudo apt-get install protonvpn-cli --upgrade -y
#sudo apt-get install gdebi-core -y
#sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#sudo mv google-chrome-stable_current_amd64.deb /opt/google-chrome.deb
#sudo gdebi /opt/google-chrome.deb -y
sudo apt-get install joplin -y
sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py; python get-pip.py
sudo touch /etc/apt/sources.list.d/insync.list
sudo echo "deb http://apt.insync.io/debian buster non-free contrib" > /etc/apt/sources.list.d/insync.list
sudo apt-get update
sudo apt-get install insync -y
#sudo wget -O vmware.bundle https://www.vmware.com/go/getworkstation-linux
#sudo chmod 777 vmware.bundle
#sudo ./vmware.bundle
#DOWNLOAD Nessus First
#sudo dpkg -i Downloads/Nessus-8.13.0-debian6_amd64.deb
#sudo rm Downloads/Nessus-8.13.0-debian6_amd64.deb
sudo apt-get install linux headers-$(uname -r)
#sudo usermod -a -G sudo <USERNAME>
sudo apt-get install npm -y
#sudo apt-get install -y python3
#sudo apt-get install python3-pip -y
sudo apt-get install software-properties-common apt-transport-https curl -y
#sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
#sudo apt-get update
sudo apt-get install code -y
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo apt-get update
sudo apt-get upgrade all -y
sudo apt-get autoclean -y
sudo apt-get autoremove -y

