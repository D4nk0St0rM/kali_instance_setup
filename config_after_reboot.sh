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

myvim="https://raw.githubusercontent.com/D4nk0St0rM/kali_instance_setup/main/_vimrc.rc"
myzsh="https://raw.githubusercontent.com/D4nk0St0rM/kali_instance_setup/main/zshrc"
mytmux="https://raw.githubusercontent.com/D4nk0St0rM/kali_instance_setup/main/tmux.conf"
mybash="https://raw.githubusercontent.com/D4nk0St0rM/kali_instance_setup/main/bashrc"

##### Terminals and text editors
echo -e "\n ${GREEN}[+]${RESET}Installing ZSH & Oh-My-ZSH ${GREEN} ~ unix shell ${RESET}"
#--- Setup oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#--- Configure zsh
file=~/.zshrc; [ -e "$file" ] && cp -n $file{,.bkup}   #/etc/zsh/zshrc
wget $myzsh
mv zshrc $file
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sudo apt install tmux

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

wget $mytmux
mv tmux.conf .tmux.conf
wget $mybash
mv ~/.bashrc ~/.bashrc_bak
mv bashrc ~/.bashrc

