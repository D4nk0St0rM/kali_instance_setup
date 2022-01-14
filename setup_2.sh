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
myvim="https://raw.githubusercontent.com/D4nk0St0rM/kali_instance_setup/main/_vimrc.rc"

#### update
echo -e "\n ${GREEN}[+]${RESET} ${GREEN}Updating OS${RESET} from repositories ~ this ${BOLD}may take a while${RESET} depending on your connection & last time you updated / distro version"
echo -e "\n ${GREEN}[+]${RESET} Installing ${GREEN}kali-linux-large${RESET} meta-package ~ this ${BOLD}may take a while${RESET} depending on your Kali version / network etc etc...."
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
sudo locale-gen en_GB.UTF-8
sudo dpkg-reconfigure locales # manual input required
sudo update-locale LANG=en_GB.UTF-8
sudo setxkbmap -layout gb

#####  Changing time zone
echo -e "\n ${GREEN}[+]${RESET} Updating ${GREEN}location information${RESET} ~ time zone (${BOLD}Europe/London${RESET})"
sudo cp /usr/share/zoneinfo/Europe/London /etc/localtime

##### Install GNOME Terminator
echo -e "\n ${GREEN}[+]${RESET} Installing GNOME ${GREEN}Terminator${RESET} ~ multiple terminals in a single window"
sudo apt-get -y -qq install terminator || echo -e ' '${RED}'[!] Issue with apt-get'${RESET} 1>&2
#--- Configure terminator
mkdir -p ~/.config/terminator/
file=~/.config/terminator/config; [ -e "${file}" ] && cp -n $file{,.bkup}
[ -e "${file}" ] || cat <<-EOF > "${file}"
[global_config]
  enabled_plugins = TerminalShot, LaunchpadCodeURLHandler, APTURLHandler, LaunchpadBugURLHandler
[keybindings]
[profiles]
  [[default]]
    background_darkness = 0.9
    scroll_on_output = False
    copy_on_selection = True
    background_type = transparent
    scrollback_infinite = True
    show_titlebar = False
[layouts]
  [[default]]
    [[[child1]]]
      type = Terminal
      parent = window0
    [[[window0]]]
      type = Window
      parent = ""
[plugins]
EOF

##### vim - all users
echo -e "\n ${GREEN}[+]${RESET} Installing ${GREEN}vim${RESET} ~ CLI text editor"
sudo apt-get -y -qq install vim || echo -e ' '${RED}'[!] Issue with apt-get'${RESET} 1>&2

mkdir -p ~/.vim ~/.vim/autoload ~/.vim/backup ~/.vim/color ~/.vim/plugged
wget $myvim
mv _vimrc.rc ~/.vimrc

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

echo -e "\n ${GREEN}[+]${RESET} Housekeeping ${GREEN} - add architecure & windows tools ${RESET}"
sudo dpkg --add-architecture i386 && sudo apt-get update 1> /dev/null

echo -e "\n ${GREEN}[+]${RESET} Housekeeping ${GREEN} - searchsploit update ${RESET}"
sudo searchsploit u 1> /dev/null


echo -e "\n ${GREEN}[+]${RESET} File & Folder Management ${GREEN} - Delete, add, folders,files,configs ${RESET}"
sudo rm app-install.list*
sudo rm sources.list*

echo -e "\n ${GREEN}[+]${RESET} Final clean up &reboot ${GREEN} ...............Byeeeee ${RESET}"

sudo apt-get  -y -qq autoremove
# sudo reboot -f
