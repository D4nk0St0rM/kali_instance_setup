#!/bin/bash

##### Installing ZSH & Oh-My-ZSH - root user.   Note: If you use thurar, 'Open terminal here', will not work.
echo -e "\n $GREEN[+]$RESET Installing ZSH & Oh-My-ZSH ~ unix shell"
#group="sudo"
apt-get -y -qq install zsh git curl
#--- Setup oh-my-zsh
curl --progress -k -L "https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh" | zsh    #curl -s -L "https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh"
#--- Configure zsh
file=/root/.zshrc; [ -e "$file" ] && cp -n $file{,.bkup}   #/etc/zsh/zshrc
([[ -e "$file" && "$(tail -c 1 $file)" != "" ]]) && echo >> "$file"
grep -q 'interactivecomments' "$file" 2>/dev/null || echo 'setopt interactivecomments' >> "$file"
grep -q 'ignoreeof' "$file" 2>/dev/null || echo 'setopt ignoreeof' >> "$file"
grep -q 'correctall' "$file" 2>/dev/null || echo 'setopt correctall' >> "$file"
grep -q 'globdots' "$file" 2>/dev/null || echo 'setopt globdots' >> "$file"
grep -q '.bash_aliases' "$file" 2>/dev/null || echo 'source $HOME/.bash_aliases' >> "$file"
grep -q '/usr/bin/tmux' "$file" 2>/dev/null || echo '#if ([[ -z "$TMUX" && -n "$SSH_CONNECTION" ]]); then /usr/bin/tmux attach || /usr/bin/tmux new; fi' >> "$file"   # If not already in tmux and via SSH
#--- Configure zsh (themes) ~ https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
sed -i 's/ZSH_THEME=.*/ZSH_THEME="alanpeabody"/' "$file"   # Other themes: alanpeabody, jreese,   mh,   candy,   terminalparty, kardan,   nicoulaj, sunaku
#--- Configure oh-my-zsh
sed -i 's/.*DISABLE_AUTO_UPDATE="true"/DISABLE_AUTO_UPDATE="true"/' "$file"
sed -i 's/plugins=(.*)/plugins=(git tmux last-working-dir)/' "$file"
#--- Set zsh as default shell (current user)
chsh -s "$(which zsh)"
#--- Use it ~ Not much point to it being a post-install script
#/usr/bin/env zsh      # Use it
#source "$file"          # Make sure to reload our config
#--- Copy it to other user(s)
#if [ -e "/home/$username/" ]; then   # Will do this later on again, if there isn't already a user
#  cp -f /{root,home/$username}/.zshrc
#  cp -rf /{root,home/$username}/.oh-my-zsh/
#  chown -R $username\:$group /home/$username/.zshrc /home/$username/.oh-my-zsh/
#  chsh "$username" -s "$(which zsh)"
#  sed -i 's#^export ZSH=/.*/.oh-my-zsh#export ZSH=/home/'$username'/.oh-my-zsh#' /home/$username/.zshrc
#fi


##### Installing tmux - all users
echo -e "\n $GREEN[+]$RESET Installing tmux ~ multiplex virtual consoles"
#group="sudo"
#apt-get -y -qq remove screen   # Optional: If we're going to have/use tmux, why have screen?
apt-get -y -qq install tmux
#--- Configure tmux
file=/root/.tmux.conf; [ -e "$file" ] && cp -n $file{,.bkup}   #/etc/tmux.conf
cat <<EOF > "$file"
#-Settings---------------------------------------------------------------------
## Make it like screen (use CTRL+a)
unbind C-b
set -g prefix C-a
## Pane switching (SHIFT+ARROWS)
bind-key -n S-Left select-pane -L
bind-key -n S-Right select-pane -R
bind-key -n S-Up select-pane -U
bind-key -n S-Down select-pane -D
## Windows switching (ALT+ARROWS)
bind-key -n M-Left  previous-window
bind-key -n M-Right next-window
## Windows re-ording (SHIFT+ALT+ARROWS)
bind-key -n M-S-Left swap-window -t -1
bind-key -n M-S-Right swap-window -t +1
## Activity Monitoring
setw -g monitor-activity on
set -g visual-activity on
## Set defaults
set -g default-terminal screen-256color
set -g history-limit 5000
## Default windows titles
set -g set-titles on
set -g set-titles-string '#(whoami)@#H - #I:#W'
## Last window switch
bind-key C-a last-window
## Reload settings (CTRL+a -> r)
unbind r
bind r source-file /etc/tmux.conf
## Load custom sources
#source ~/.bashrc   #(issues if you use /bin/bash & Debian)
EOF
[ -e /bin/zsh ] && echo -e '## Use ZSH as default shell\nset-option -g default-shell /bin/zsh\n' >> "$file"      # Need to have ZSH installed before running this command/line
cat <<EOF >> "$file"
## Show tmux messages for longer
set -g display-time 3000
## Status bar is redrawn every minute
set -g status-interval 60
#-Theme------------------------------------------------------------------------
## Default colours
set -g status-bg black
set -g status-fg white
## Left hand side
set -g status-left-length '34'
set -g status-left '#[fg=green,bold]#(whoami)#[default]@#[fg=yellow,dim]#H #[fg=green,dim][#[fg=yellow]#(cut -d " " -f 1-3 /proc/loadavg)#[fg=green,dim]]'
## Inactive windows in status bar
set-window-option -g window-status-format '#[fg=red,dim]#I#[fg=grey,dim]:#[default,dim]#W#[fg=grey,dim]'
## Current or active window in status bar
#set-window-option -g window-status-current-format '#[bg=white,fg=red]#I#[bg=white,fg=grey]:#[bg=white,fg=black]#W#[fg=dim]#F'
set-window-option -g window-status-current-format '#[fg=red,bold](#[fg=white,bold]#I#[fg=red,dim]:#[fg=white,bold]#W#[fg=red,bold])'
## Right hand side
set -g status-right '#[fg=green][#[fg=yellow]%Y-%m-%d #[fg=white]%H:%M#[fg=green]]'
EOF
#--- Setup alias
file=/root/.bash_aliases; [ -e "$file" ] && cp -n $file{,.bkup}   #/etc/bash.bash_aliases
([[ -e "$file" && "$(tail -c 1 $file)" != "" ]]) && echo >> "$file"
grep -q '^alias tmux' "$file" 2>/dev/null || echo -e '## tmux\nalias tmux="tmux attach || tmux new"\n' >> "$file"    #alias tmux="tmux attach -t $HOST || tmux new -s $HOST"
#--- Apply new aliases
if [[ "$SHELL" == "/bin/zsh" ]]; then source ~/.zshrc else source "$file"; fi
#--- Copy it to other user(s) ~
#if [ -e /home/$username/ ]; then   # Will do this later on again, if there isn't already a user
#  cp -f /{etc/,home/$username/.}tmux.conf    #cp -f /{root,home/$username}/.tmux.conf
#  chown $username\:$group /home/$username/.tmux.conf
#  file=/home/$username/.bash_aliases; [ -e "$file" ] && cp -n $file{,.bkup}
#  grep -q '^alias tmux' "$file" 2>/dev/null || echo -e '## tmux\nalias tmux="tmux attach || tmux new"\n' >> "$file"    #alias tmux="tmux attach -t $HOST || tmux new -s $HOST"
#fi
#--- Use it ~ bit pointless if used in a post-install script
#tmux


##### Configuring screen ~ if possible, use tmux instead!
echo -e "\n $GREEN[+]$RESET Configuring screen ~ multiplex virtual consoles"
#apt-get -y -qq install screen
#--- Configure screen
file=/root/.screenrc; [ -e "$file" ] && cp -n $file{,.bkup}
cat <<EOF > "$file"
## Don't display the copyright page
startup_message off
## tab-completion flash in heading bar
vbell off
## Keep scrollback n lines
defscrollback 1000
## Hardstatus is a bar of text that is visible in all screens
hardstatus on
hardstatus alwayslastline
hardstatus string '%{gk}%{G}%H %{g}[%{Y}%l%{g}] %= %{wk}%?%-w%?%{=b kR}(%{W}%n %t%?(%u)%?%{=b kR})%{= kw}%?%+w%?%?%= %{g} %{Y} %Y-%m-%d %C%a %{W}'
## Title bar
termcapinfo xterm ti@:te@
## Default windows (syntax: screen -t label order command)
screen -t bash1 0
screen -t bash2 1
## Select the default window
select 0
EOF


##### Configuring vim - all users
echo -e "\n $GREEN[+]$RESET Configuring vim ~ CLI text editor"
apt-get -y -qq install vim
#--- Configure vim
file=/etc/vim/vimrc; [ -e "$file" ] && cp -n $file{,.bkup}   #/root/.vimrc
([[ -e "$file" && "$(tail -c 1 $file)" != "" ]]) && echo >> "$file"
sed -i 's/.*syntax on/syntax on/' "$file"
sed -i 's/.*set background=dark/set background=dark/' "$file"
sed -i 's/.*set showcmd/set showcmd/' "$file"
sed -i 's/.*set showmatch/set showmatch/' "$file"
sed -i 's/.*set ignorecase/set ignorecase/' "$file"
sed -i 's/.*set smartcase/set smartcase/' "$file"
sed -i 's/.*set incsearch/set incsearch/' "$file"
sed -i 's/.*set autowrite/set autowrite/' "$file"
sed -i 's/.*set hidden/set hidden/' "$file"
sed -i 's/.*set mouse=.*/"set mouse=a/' "$file"
grep -q '^set number' "$file" 2>/dev/null || echo 'set number' >> "$file"                                                                        # Add line numbers
grep -q '^set autoindent' "$file" 2>/dev/null || echo 'set autoindent' >> "$file"                                                                # Set auto indent
grep -q '^set expandtab' "$file" 2>/dev/null || echo -e 'set expandtab\nset smarttab' >> "$file"                                                 # Set use spaces instead of tabs
grep -q '^set softtabstop' "$file" 2>/dev/null || echo -e 'set softtabstop=4\nset shiftwidth=4' >> "$file"                                       # Set 4 spaces as a 'tab'
grep -q '^set foldmethod=marker' "$file" 2>/dev/null || echo 'set foldmethod=marker' >> "$file"                                                  # Folding
grep -q '^nnoremap <space> za' "$file" 2>/dev/null || echo 'nnoremap <space> za' >> "$file"                                                      # Space toggle folds
grep -q '^set hlsearch' "$file" 2>/dev/null || echo 'set hlsearch' >> "$file"                                                                    # Highlight search results
grep -q '^set laststatus' "$file" 2>/dev/null || echo -e 'set laststatus=2\nset statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]' >> "$file"   # Status bar
grep -q '^filetype on' "$file" 2>/dev/null || echo -e 'filetype on\nfiletype plugin on\nsyntax enable\nset grepprg=grep\ -nH\ $*' >> "$file"     # Syntax highlighting
grep -q '^set wildmenu' "$file" 2>/dev/null || echo -e 'set wildmenu\nset wildmode=list:longest,full' >> "$file"                                 # Tab completion
grep -q '^set invnumber' "$file" 2>/dev/null || echo -e ':nmap <F8> :set invnumber<CR>' >> "$file"                                               # Toggle line numbers
grep -q '^set pastetoggle=<F9>' "$file" 2>/dev/null || echo -e 'set pastetoggle=<F9>' >> "$file"                                                 # Hotkey - turning off auto indent when pasting
grep -q '^:command Q q' "$file" 2>/dev/null || echo -e ':command Q q' >> "$file"                                                                 # Fix stupid typo I always make
#--- Set as default editor
export EDITOR="vim"   #update-alternatives --config editor
file=/etc/bash.bashrc; [ -e "$file" ] && cp -n $file{,.bkup}
([[ -e "$file" && "$(tail -c 1 $file)" != "" ]]) && echo >> "$file"
grep -q '^EDITOR' "$file" 2>/dev/null || echo 'EDITOR="vim"' >> "$file"
git config --global core.editor "vim"
#--- Set as default mergetool
git config --global merge.tool vimdiff
git config --global merge.conflictstyle diff3
git config --global mergetool.prompt false
