#!/bin/bash

## D4nk0St0rM
#### #### #### #### spread l0ve & kn0wledge #### #### #### ####
# Created after some inspiration from blacklanternsecurity & g0tmi1k scripts
# Create user to not require password for sudo [sudo visudo / theUSER ALL=(ALL) NOPASSWD:ALL)
# Use the following for password-less privesc : sudo apt-get install -y -y kali-grant-root && sudo dpkg-reconfigure kali-grant-root

#### Enable debug mode
#set -x

#### skip prompts in apt-upgrade, etc.
export DEBIAN_FRONTEND=noninteractive
alias ='yes "" | apt-get -o Dpkg::Options::="--force-confdef" -y'


#### update sources.list
echo -e "\n ${GREEN}[+]${RESET} Updating ${GREEN}Sources${RESET} ~ dot list and other repos (${BOLD}gb${RESET})"

file=/etc/apt/sources.list; [ -e "${file}" ] && cp -n $file{,.bkup}
([[ -e "${file}" && "$(tail -c 1 ${file})" != "" ]]) && echo >> "${file}"
wget https://raw.githubusercontent.com/D4nk0St0rM/new_kali_instance_setup/main/sources.list
sudo mv sources.list $file


#### Add repo keys
wget -q -O - https://repo.protonvpn.com/debian/public_key.asc | sudo tee -a /usr/share/keyrings/protonvpn.asc
sudo apt-get -qq update
sudo apt-get install -y -qq dist-upgrade 
sudo apt-get install -y -qq kali-linux-large
sudo apt-get install -y -qq software-properties-common
sudo apt-get install -y -qq gnupg-agent
if [[ "$?" -ne 0 ]]; then
    echo -e ' '${RED}'[!]'${RESET}" There was an ${RED}issue accessing network repositories${RESET}" 1>&2
    echo -e " ${YELLOW}[i]${RESET} Are the remote network repositories ${YELLOW}currently being sync'd${RESET}?"
    echo -e " ${YELLOW}[i]${RESET} YOUR ${YELLOW}network repositories information${RESET}:"
    curl -sI http://http.kali.org/README
    exit 1
  fi


##### Colour output
RED="\033[01;31m"      # Issues/Errors
GREEN="\033[01;32m"    # Success
YELLOW="\033[01;33m"   # Warnings/Information
BLUE="\033[01;34m"     # Heading
BOLD="\033[01;01m"     # Highlight
RESET="\033[00m"       # Normal



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

sudo update-locale LANG=en_GB.UTF-8

#####location information
echo -e "\n ${GREEN}[+]${RESET} Updating ${GREEN}location information${RESET} ~ keyboard layout (${BOLD}gb${RESET})"
geoip_keyboard=$(curl -s http://ifconfig.io/country_code | tr '[:upper:]' '[:lower:]')
[ "${geoip_keyboard}" != "gb" ] && echo -e " ${YELLOW}[i]${RESET} Keyboard layout (${BOLD}gb${RESET}}) doesn't match what's been detected via GeoIP (${BOLD}${geoip_keyboard}${RESET}})"
file=/etc/default/keyboard; #[ -e "${file}" ] && cp -n $file{,.bkup}
sed -i 's/XKBLAYOUT=".*"/XKBLAYOUT="'gb'"/' "${file}"

#####  Changing time zone
echo -e "\n ${GREEN}[+]${RESET} Updating ${GREEN}location information${RESET} ~ time zone (${BOLD}Europe/London${RESET})"
echo "Europe/London" > /etc/timezone
ln -sf "/usr/share/zoneinfo/$(cat /etc/timezone)" /etc/localtime
dpkg-reconfigure -f noninteractive tzdata

##### update 
 echo -e "\n ${GREEN}[+]${RESET} ${GREEN}Updating OS${RESET} from repositories ~ this ${BOLD}may take a while${RESET} depending on your connection & last time you updated / distro version"
for FILE in clean autoremove; do apt-get -y -qq "${FILE}"; done         # Clean up      clean remove autoremove autoclean
export DEBIAN_FRONTEND=noninteractive
sudo apt-get -y -qq update && APT_LISTCHANGES_FRONTEND=none apt-get -o Dpkg::Options::="--force-confnew" -y dist-upgrade --fix-missing || echo -e ' '${RED}'[!] Issue with apt-get'${RESET} 1>&2
#--- Cleaning up temp stuff
for FILE in clean autoremove; do sudo apt-get -y -qq "${FILE}"; done         # Clean up - clean remove autoremove autoclean

###### kernel
_TMP=$(dpkg -l | grep linux-image- | grep -vc meta)
if [[ "${_TMP}" -gt 1 ]]; then
  echo -e "\n ${YELLOW}[i]${RESET} Detected multiple kernels installed"
  TMP=$(dpkg -l | grep linux-image | grep -v meta | sort -t '.' -k 2 -g | tail -n 1 | grep "$(uname -r)")
  [[ -z "${_TMP}" ]] && echo -e ' '${RED}'[!]'${RESET}' You are '${RED}'not using the latest kernel'${RESET} 1>&2 && echo -e " ${YELLOW}[i]${RESET} You have it downloaded & installed, ${YELLOW}just not using it${RESET}. You ${YELLOW}need to reboot${RESET}" && exit 1
  echo -e " ${YELLOW}[i]${RESET}   Clean up: apt-get remove --purge $(dpkg -l 'linux-image-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d')"  
  echo -e " ${RED}[i]${RESET}    DO NOT RUN IF NOT USING THE LASTEST KERNEL!"
fi

##### Install kernel headers
echo -e "\n ${GREEN}[+]${RESET} Installing ${GREEN}kernel headers${RESET}"
sudo apt-get -y -qq install make gcc "linux-headers-$(uname -r)" || echo -e ' '${RED}'[!] Issue with apt-get'${RESET} 1>&2
if [[ $? -ne 0 ]]; then
  echo -e ' '${RED}'[!]'${RESET}" There was an ${RED}issue installing kernel headers${RESET}" 1>&2
  echo -e " ${YELLOW}[i]${RESET} Are you ${YELLOW}USING${RESET} the ${YELLOW}latest kernel${RESET}?"
  echo -e " ${YELLOW}[i]${RESET} ${YELLOW}Reboot your machine${RESET}"
  exit 1
fi

##### Install kali large metapackage
# https://tools.kali.org/kali-metapackages
echo -e "\n ${GREEN}[+]${RESET} Installing ${GREEN}kali-linux-large${RESET} meta-package ~ this ${BOLD}may take a while${RESET} depending on your Kali version / network etc etc...."
sudo apt-get -y -qq install kali-linux-large || echo -e ' '${RED}'[!] Issue with apt-get'${RESET} 1>&2

##### Configure bash - all users
echo -e "\n ${GREEN}[+]${RESET} Configuring ${GREEN}bash${RESET} ~ CLI shell"
file=/etc/bash.bashrc; [ -e "${file}" ] && cp -n $file{,.bkup}   #~/.bashrc
grep -q "cdspell" "${file}" || echo "shopt -sq cdspell" >> "${file}"             # Spell check 'cd' commands
grep -q "checkwinsize" "${file}" || echo "shopt -sq checkwinsize" >> "${file}"   # Wrap lines correctly after resizing
grep -q "HISTSIZE" "${file}" || echo "HISTSIZE=100000" >> "${file}"               # Bash history (memory scroll back)
grep -q "HISTFILESIZE" "${file}" || echo "HISTFILESIZE=100000" >> "${file}"       # Bash history (file .bash_history)
grep -q "^alias ls='ls $LS_OPTIONS'" "${file}" 2>/dev/null || echo "alias ls='ls $LS_OPTIONS'" >> "${file}"
grep -q "^alias ll='ls $LS_OPTIONS -l'" "${file}" 2>/dev/null || echo "alias ll='ls $LS_OPTIONS -l'" >> "${file}"
grep -q "^alias l='ls $LS_OPTIONS -lA'" "${file}" 2>/dev/null || echo "alias l='ls $LS_OPTIONS -lA'" >> "${file}"
#--- Apply new configs
if [[ "${SHELL}" == "/bin/zsh" ]]; then source ~/.zshrc else source "${file}"; fi


##### Install bash colour - all users
echo -e "\n ${GREEN}[+]${RESET} Installing ${GREEN}bash colour${RESET} ~ colours shell output"
file=/etc/bash.bashrc; [ -e "${file}" ] && cp -n $file{,.bkup}   #~/.bashrc
([[ -e "${file}" && "$(tail -c 1 ${file})" != "" ]]) && echo >> "${file}"
sed -i 's/.*force_color_prompt=.*/force_color_prompt=yes/' "${file}"
grep -q '^force_color_prompt' "${file}" 2>/dev/null || echo 'force_color_prompt=yes' >> "${file}"
sed -i 's#PS1='"'"'.*'"'"'#PS1='"'"'${debian_chroot:+($debian_chroot)}\\[\\033\[01;31m\\]\\u@\\h\\\[\\033\[00m\\]:\\[\\033\[01;34m\\]\\w\\[\\033\[00m\\]\\$ '"'"'#' "${file}"
grep -q "^export LS_OPTIONS='--color=auto'" "${file}" 2>/dev/null || echo "export LS_OPTIONS='--color=auto'" >> "${file}"
grep -q '^eval "$(dircolors)"' "${file}" 2>/dev/null || echo 'eval "$(dircolors)"' >> "${file}"
grep -q "^alias ls='ls $LS_OPTIONS'" "${file}" 2>/dev/null || echo "alias ls='ls $LS_OPTIONS'" >> "${file}"
grep -q "^alias ll='ls $LS_OPTIONS -l'" "${file}" 2>/dev/null || echo "alias ll='ls $LS_OPTIONS -l'" >> "${file}"
grep -q "^alias l='ls $LS_OPTIONS -lA'" "${file}" 2>/dev/null || echo "alias l='ls $LS_OPTIONS -lA'" >> "${file}"

#--- Apply new configs
if [[ "${SHELL}" == "/bin/zsh" ]]; then source ~/.zshrc else source "${file}"; fi

##### Install GNOME Terminator
echo -e "\n ${GREEN}[+]${RESET} Installing GNOME ${GREEN}Terminator${RESET} ~ multiple terminals in a single window"
apt-get -y -qq install terminator || echo -e ' '${RED}'[!] Issue with apt-get'${RESET} 1>&2
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

##### Ivim - all users
echo -e "\n ${GREEN}[+]${RESET} Installing ${GREEN}vim${RESET} ~ CLI text editor"
sudo apt-get -y -qq install vim || echo -e ' '${RED}'[!] Issue with apt-get'${RESET} 1>&2
#--- Configure vim
file=/etc/vim/vimrc; [ -e "${file}" ] && cp -n $file{,.bkup}   #~/.vimrc
([[ -e "${file}" && "$(tail -c 1 ${file})" != "" ]]) && echo >> "${file}"
sed -i 's/.*syntax on/syntax on/' "${file}"
sed -i 's/.*set background=dark/set background=dark/' "${file}"
sed -i 's/.*set showcmd/set showcmd/' "${file}"
sed -i 's/.*set showmatch/set showmatch/' "${file}"
sed -i 's/.*set ignorecase/set ignorecase/' "${file}"
sed -i 's/.*set smartcase/set smartcase/' "${file}"
sed -i 's/.*set incsearch/set incsearch/' "${file}"
sed -i 's/.*set autowrite/set autowrite/' "${file}"
sed -i 's/.*set hidden/set hidden/' "${file}"
sed -i 's/.*set mouse=.*/"set mouse=a/' "${file}"
grep -q '^set number' "${file}" 2>/dev/null || echo 'set number' >> "${file}"                                                                        # Add line numbers
grep -q '^set autoindent' "${file}" 2>/dev/null || echo 'set autoindent' >> "${file}"                                                                # Set auto indent
grep -q '^set expandtab' "${file}" 2>/dev/null || echo -e 'set expandtab\nset smarttab' >> "${file}"                                                 # Set use spaces instead of tabs
grep -q '^set softtabstop' "${file}" 2>/dev/null || echo -e 'set softtabstop=4\nset shiftwidth=4' >> "${file}"                                       # Set 4 spaces as a 'tab'
grep -q '^set foldmethod=marker' "${file}" 2>/dev/null || echo 'set foldmethod=marker' >> "${file}"                                                  # Folding
grep -q '^nnoremap <space> za' "${file}" 2>/dev/null || echo 'nnoremap <space> za' >> "${file}"                                                      # Space toggle folds
grep -q '^set hlsearch' "${file}" 2>/dev/null || echo 'set hlsearch' >> "${file}"                                                                    # Highlight search results
grep -q '^set laststatus' "${file}" 2>/dev/null || echo -e 'set laststatus=2\nset statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]' >> "${file}"   # Status bar
grep -q '^filetype on' "${file}" 2>/dev/null || echo -e 'filetype on\nfiletype plugin on\nsyntax enable\nset grepprg=grep\ -nH\ $*' >> "${file}"     # Syntax highlighting
grep -q '^set wildmenu' "${file}" 2>/dev/null || echo -e 'set wildmenu\nset wildmode=list:longest,full' >> "${file}"                                 # Tab completion
grep -q '^set invnumber' "${file}" 2>/dev/null || echo -e ':nmap <F8> :set invnumber<CR>' >> "${file}"                                               # Toggle line numbers
grep -q '^set pastetoggle=<F9>' "${file}" 2>/dev/null || echo -e 'set pastetoggle=<F9>' >> "${file}"                                                 # Hotkey - turning off auto indent when pasting
grep -q '^:command Q q' "${file}" 2>/dev/null || echo -e ':command Q q' >> "${file}"                                                                 # Fix stupid typo I always make


#--- Set as default editor
export EDITOR="vim"   #update-alternatives --config editor
file=/etc/bash.bashrc; [ -e "${file}" ] && cp -n $file{,.bkup}
([[ -e "${file}" && "$(tail -c 1 ${file})" != "" ]]) && echo >> "${file}"
grep -q '^EDITOR' "${file}" 2>/dev/null || echo 'EDITOR="vim"' >> "${file}"
git config --global core.editor "vim"

##### Set static & protecting DNS name servers.   Note: May cause issues with forced values (e.g. captive portals etc)
  echo -e "\n ${GREEN}[+]${RESET} Setting static & protecting ${GREEN}DNS name servers${RESET}"
  file=/etc/resolv.conf; [ -e "${file}" ] && cp -n $file{,.bkup}
  chattr -i "${file}" 2>/dev/null
  #--- Remove duplicate results
  #uniq "${file}" > "$file.new"; mv $file{.new,}
  #--- Use OpenDNS DNS
  #echo -e 'nameserver 208.67.222.222\nnameserver 208.67.220.220' > "${file}"
  #--- Use Google DNS
  #echo -e 'nameserver 8.8.8.8\nnameserver 8.8.4.4' > "${file}"
  #--- Use Quad9 DNS
  echo -e 'nameserver 9.9.9.9\nnameserver 149.112.112.112' > "${file}"
  #--- Add domain
  #echo -e "domain ${domainName}\n#search ${domainName}" >> "${file}"
  #--- Protect it
  chattr +i "${file}" 2>/dev/null




echo -e "\n ${GREEN}[+]${RESET} Installation of applications ${GREEN}TimeShift - backup & snapshots ${RESET}"
sudo apt-get install -y -qq timeshift

echo -e "\n ${GREEN}[+]${RESET} Installation of applications ${GREEN}transport protocols ${RESET}"
sudo apt-get install -y -qq apt-transport-https

echo -e "\n ${GREEN}[+]${RESET} Installation of applications ${GREEN}MS visual code studio ${RESET}"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft-archive-keyring.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install -y -qq code
sudo rm microsoft.gpg


echo -e "\n ${GREEN}[+]${RESET} File & Folder Management ${GREEN} - Unzip files ${RESET}"
sudo rm /usr/share/wordlists/rockyou.txt || echo -e ' '${RED}'[!] rockyou.txt does not exist'${RESET} 1>&2
sudo gunzip /usr/share/wordlists/rockyou.txt.gz


echo -e "\n ${GREEN}[+]${RESET} File & Folder Management ${GREEN} - Delete Folders or files ${RESET}"


echo -e "\n ${GREEN}[+]${RESET} Final clean up &reboot ${GREEN} ...............Byeeeee ${RESET}"
s
sudo apt-get  -y -qq autoremove
# sudo reboot -f

