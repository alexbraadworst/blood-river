#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
cat << "EOF"
 _    _      _                               ___  _      _    _        
| |  | |    | |                             / _ \| |    | |  | |       
| |  | | ___| | ___ ___  _ __ ___   ___    / /_\ \ | ___| | _| | _____ 
| |/\| |/ _ \ |/ __/ _ \| '_ ' _ \ / _ \   |  _  | |/ _ \ |/ / |/ / __|
\  /\  /  __/ | (_| (_) | | | | | |  __/_  | | | | |  __/   <|   <\__ \
 \/  \/ \___|_|\___\___/|_| |_| |_|\___( ) \_| |_/_|\___|_|\_\_|\_\___/
                                       |/                                                                                               
EOF
#PS1='[\u@\h \W]\$ '
PS1='\u@\h: \W \n> '
export EDITOR='nvim'
export XDG_CURRENT_DESKTOP='sway'
shopt -s expand_aliases
source ~/.bash_aliases
. "$HOME/.cargo/env"

source ~/utilities/scripts/quitcd.bash_sh_zsh
#sway & disown
