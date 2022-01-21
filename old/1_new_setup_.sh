#!/bin/bash


#### D4nk0St0rM
#### spread l0v3, share kn0wl3dge

# update https://github.com/D4nk0St0rM/simple_linux_tweaks/blob/main/sources.list
# create user to not require password for sudo [sudo visudo / theUSER ALL=(ALL) NOPASSWD:ALL)
# wallpaper: https://raw.githubusercontent.com/D4nk0St0rM/simple_linux_tweaks/main/wallpaper/Kali_dark_shadow_eye.jpg

RED='\033[0;31m'
NC='\033[0m' # No Color
reset_colour='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32  m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'


echo -e ${RED}"## Hold on to your hats.... cats"${NC}

echo -e ${RED}"update & upgrade"${NC}
sudo apt-get update
# sudo apt-get upgrade
# sudo apt-get dist-upgrade -y
sudo apt-get install kali-linux-large -y

echo -e ${RED}"~#~ GB Keyboard"${NC}
sudo setxkbmap -layout gb

echo -e ${RED}"~#~ update and install some fundamental tools for running environment"${NC}

sudo apt-get install -y git
# sudo apt-get install -y python3.7 python3-pip python2.7 python-pip
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python get-pip.py
rm get-pip.py
sudo apt-get install dbus-x11 -y
sudo apt-get install gnome-themes-standard -y
# sudo apt-get install kali-linux-large -y
sudo apt-get install software-properties-common apt-transport-https curl -y
sudo apt-get install linux headers-$(uname -r) -y
sudo apt-get install hcxdumptool -y
sudo apt-get install hcxtools -y
sudo apt-get install dnsutils -y
sudo apt-get install exiftool -y
sudo apt-get install openvpn -y
sudo apt-get install dialog -y
sudo apt-get install protonvpn-cli -y
sudo apt-get install edb-debugger -y

echo -e ${RED}"~#~ Some structure changes, deleting and creating folders, & virtual python envs"${NC}
rm -r Music/
rm -r Templates/
rm -r Videos/
rm -r Public/
mkdir ~/Documents/vhl
mkdir ~/Documents/htb
mkdir ~/Documents/general
mkdir ~/.virtualenv
mkdir /opt/mytools
mytools="/opt/mytools"
virtenv="~/.virtualenv"

echo -e ${RED}"~#~ install a bunch git clones to /opt/mytools"${NC}
echo -e ${YELLOW}"~#~ ~#~ ~#~ ~#~ ~#~ ~#~ ~#~ ~#~ ~#~"${NC}
echo -e ${CYAN}"~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~"${NC}

echo -e ${RED}"~#~ SecLists [now kali install]"${NC}
sudo apt-get install seclists -y

echo -e ${RED}"~#~ h8mail"${NC}
sudo git clone https://github.com/khast3x/h8mail $mytools/h8mail

echo -e ${RED}"~#~ discover"${NC}
sudo git clone https://github.com/leebaird/discover $mytools/discover

echo -e ${RED}"~#~ nmap automator"${NC}
sudo git clone https://github.com/21y4d/nmapAutomator.git $mytools/nmapAutomator

echo -e ${RED}"~#~ subbrute"${NC}
sudo git clone https://github.com/TheRook/subbrute.git $mytools/subbrute

echo -e $fg[yellow]"~#~ theHarvester"${NC}
sudo git clone https://github.com/laramies/theHarvester.git $mytools/theHarvester

echo -e ${RED}"~#~ windows exploit suggester"${NC}
sudo git clone https://github.com/AonCyberLabs/Windows-Exploit-Suggester.git $mytools/windows-exploit-suggester

echo -e ${RED}"~#~ nmap vulners"${NC}
sudo git clone https://github.com/vulnersCom/nmap-vulners.git /usr/share/nmap/scripts/vulners

echo -e ${RED}"~#~ priv esc scripts"${NC}
sudo git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git $mytools/priv-esc-scripts

echo -e ${RED}"'~#~ sublist3r"${NC}
sudo git clone https://github.com/aboul3la/Sublist3r.git $mytools/sublist3r

echo -e ${RED}"~#~ sherlock"${NC}
sudo git clone https://github.com/sherlock-project/sherlock.git $mytools/sherlock
$ python3 -m pip install -r $mytools/sherlock/requirements.txt

echo -e ${RED}"~#~ windows reverse shell"${NC}
sudo git clone https://github.com/Dhayalanb/windows-php-reverse-shell.git $mytools/windows-reverse-shell

echo -e ${RED}"~#~ gobuster"${NC}
sudo git clone https://github.com/OJ/gobuster.git $mytools/gobuster

echo -e ${RED}"~#~ ffuf"${NC}
sudo git clone https://github.com/ffuf/ffuf.git $mytools/ffuf

echo -e ${RED}"~#~ We are done, the cats are wearing their hats"${NC}
echo -e ${YELLOW}"~#~ ~#~ ~#~ ~#~ ~#~ ~#~ ~#~ ~#~ ~#~"${NC}
echo -e ${CYAN}"~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~"${NC}

