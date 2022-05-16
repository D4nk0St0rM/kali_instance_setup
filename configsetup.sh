#!/bin/bash

## D4nk0St0rM
#### #### #### #### spread l0ve & kn0wledge #### #### #### ####
# Inspiration from blacklanternsecurity & g0tmi1k scripts

#### Enable debug mode
#set -x

##### Colour output
RED="\033[01;31m"      # Issues/Errors
GREEN="\033[01;32m"    # Success
YELLOW="\033[01;33m"   # Warnings/Information
BLUE="\033[01;34m"     # Heading
BOLD="\033[01;01m"     # Highlight
RESET="\033[00m"       # Normal

##### Exclude regular history entries
export HISTIGNORE="&:ls:[bf]g:exit:history"

mylist="https://raw.githubusercontent.com/D4nk0St0rM/kali_instance_setup/main/app-install.list"
gitlist="https://raw.githubusercontent.com/D4nk0St0rM/kali_instance_setup/main/git-clone.list"
myvim="https://raw.githubusercontent.com/D4nk0St0rM/kali_instance_setup/main/vimrc"
myzsh="https://raw.githubusercontent.com/D4nk0St0rM/kali_instance_setup/main/zshrc"
mytmux="https://raw.githubusercontent.com/D4nk0St0rM/kali_instance_setup/main/tmux.conf"
mybash="https://raw.githubusercontent.com/D4nk0St0rM/kali_instance_setup/main/bashrc"

#### update
echo -e "\n ${GREEN}[+]${RESET} ${GREEN}Updating OS${RESET} from repositories ~ this ${BOLD}may take a while${RESET} depending on your connection & last time you updated / distro version"

sudo apt-get -y -qq update
sudo apt-get -y -qq upgrade --fix-missing || echo -e ' '${RED}'[!] Issue with apt-get'${RESET} 1>&2
sudo apt-get install -y -qq software-properties-common
sudo apt-get install -y -qq gnupg-agent
if [[ "$?" -ne 0 ]]; then
    echo -e ' '${RED}'[!]'${RESET}" There was an ${RED}issue accessing network repositories${RESET}" 1>&2
    echo -e " ${YELLOW}[i]${RESET} Are the remote network repositories ${YELLOW}currently being sync'd${RESET}?"
    echo -e " ${YELLOW}[i]${RESET} YOUR ${YELLOW}network repositories information${RESET}:"
    curl -sI http://http.kali.org/README
    exit 1
  fi
sudo apt-get -y -qq autoremove

############################ Start
##### Disable screensaver
  echo -e "\n ${GREEN}[+]${RESET} Disabling ${GREEN}screensaver${RESET}"
  xset s 0 0
  xset s off
  gsettings set org.gnome.desktop.session idle-delay 0   # Disable swipe on lockscreen

#### sudo no passwd - manual
sudo apt install -y kali-grant-root && sudo dpkg-reconfigure kali-grant-root

### GB Locales
echo -e "\n ${GREEN}[+]${RESET} Updating ${GREEN}location information${RESET} ~ Locales (${BOLD}gb${RESET})"
# sudo locale-gen en_GB.UTF-8
sudo dpkg-reconfigure locales # manual input required
sudo update-locale LANG=en_GB.UTF-8
sudo setxkbmap -layout gb

#####  Changing time zone
echo -e "\n ${GREEN}[+]${RESET} Updating ${GREEN}location information${RESET} ~ time zone (${BOLD}Europe/London${RESET})"
sudo cp /usr/share/zoneinfo/Europe/London /etc/localtime


##### vim - all users
echo -e "\n ${GREEN}[+]${RESET} Installing ${GREEN}vim${RESET} ~ CLI text editor"
sudo apt-get -y -qq install vim || echo -e ' '${RED}'[!] Issue with apt-get'${RESET} 1>&2

mkdir -p ~/.vim ~/.vim/autoload ~/.vim/backup ~/.vim/color ~/.vim/plugged
wget $myvim && mv vimrc ~/.vimrc

echo -e "\n ${GREEN}[+]${RESET} Installation of applications ${GREEN} - update first ${RESET}"
sudo apt-get update

wget $mylist 1>/dev/null
cat app-install.list | while read app || [[ -n $line ]];
do
    echo -e "\n ${GREEN}[+]${RESET} Installation of applications ${GREEN} - $app ${RESET}"
    sudo apt-get install -y -qq $app
    if [[ "$?" -ne 0 ]]; then
        echo -e ' '${RED}'[!]'${RESET}" There was an ${RED}issue installing $app${RESET}" 1>&2
        echo -e " ${YELLOW}[i]${RESET} There was an ${RED}issue installing $app ${YELLOW} sending to list to review${RESET}"
        echo $app >> app_not_installed.list
    fi
done

# shared folder set up
mkdir shares && sudo /usr/bin/vmhgfs-fuse .host:/ /home/kali/shares -o subtype=vmhgfs-fuse,allow_other


echo -e "\n ${GREEN}[+]${RESET} Installation of applications ${GREEN} - tempomail ${RESET}"
wget https://github.com/kavishgr/tempomail/releases/download/1.1.0/linux-amd64-tempomail.tgz
tar -xzvf linux-amd64-tempomail.tgz
sudo mv tempomail /usr/local/bin/
sudo rm linux-amd64-tempomail.tgz

echo -e "\n ${GREEN}[+]${RESET} Installation of applications ${GREEN} - chromium ${RESET}"
sudo apt-get install chromium -y

#### git clone from list

cd /opt
sudo wget $gitlist 1>/dev/null
cat git-clone.list | while read app || [[ -n $line ]];
do
    echo -e "\n ${GREEN}[+]${RESET} Installation of applications ${GREEN} - $app ${RESET}"
    sudo git clone $app
    if [[ "$?" -ne 0 ]]; then
        echo -e ' '${RED}'[!]'${RESET}" There was an ${RED}issue installing $app${RESET}" 1>&2
        echo -e " ${YELLOW}[i]${RESET} Try one thing ${RED} by deleting existing install $app ${YELLOW} removing any folders${RESET}"
    fi
done
sudo rm git-clone.list
cd ~/

echo -e "\n ${GREEN}[+]${RESET} Housekeeping ${GREEN} - Unzip files ${RESET}"
# sudo rm /usr/share/wordlists/rockyou.txt || echo -e ' '${RED}'[!] rockyou.txt does not exist'${RESET} 1>&2
sudo gunzip /usr/share/wordlists/rockyou.txt.gz || echo -e ' '${RED}'[!] rockyou.txt.gz does not exist'${RESET} 1>&2
# add rockyou2021 via shared folder


echo -e "\n ${GREEN}[+]${RESET} Housekeeping ${GREEN} - add architecure & windows tools ${RESET}"
sudo dpkg --add-architecture i386 && sudo apt-get update 1> /dev/null

echo -e "\n ${GREEN}[+]${RESET} Dependancies ${GREEN} - wifite ${RESET}"
# wifite dependancies
sudo apt install hcxdumptool
sudo apt install hcxtools
# pyrit:
sudo apt-get install libpcap-dev
sudo apt-get install python2.7-dev libssl-dev zlib1g-dev libpcap-dev
cd /opt
sudo git clone https://github.com/JPaulMora/Pyrit.git​
cd Pyrit
sudo python setup.py clean
sudo python setup.py build
sudo python setup.py install
cd ~/


echo -e "\n ${GREEN}[+]${RESET} Housekeeping ${GREEN} - searchsploit update ${RESET}"
sudo searchsploit u 1> /dev/null


echo -e "\n ${GREEN}[+]${RESET} File & Folder Management ${GREEN} - Delete, add, folders,files,configs ${RESET}"
sudo rm app-install.list*
sudo rm sources.list*

echo -e "\n ${GREEN}[+]${RESET} Final clean up &reboot ${GREEN} ...............Byeeeee ${RESET}"

echo "sudo apt-get update"
sudo apt-get update -qq
echo "sudo apt-get upgrade"
sudo apt-get upgrade -y -qq
echo "apt-get dist-upgrade"
sudo apt-get dist-upgrade -y -qq
echo "apt-get full-upgrade"
sudo apt-get full-upgrade -y -qq
echo "sudo apt-get install"
sudo apt-get install -y -qq
echo "sudo apt-get autoremove"
sudo apt-get autoremove -y -qq
echo "apt-get clean"
sudo apt-get clean -y -qq
sudo reboot -f
