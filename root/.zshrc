export ZSH=$HOME/.oh-my-zsh
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/.local/bin/:$HOME/.npm-global"
export TERM='xterm-256color'
export EDITOR='nvim'
export ARCHFLAGS="-arch x86_64"
export SSH_KEY_PATH="~/.ssh/id_rsa"

plugins=(sudo archlinux extract)

ZSH_THEME="powerlevel9k/powerlevel9k"

#setopt appendhistory autocd beep extendedglob nomatch notify
#setopt noautopushd chasedots chaselinks pushdtohome pushdsilent beep

HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"

alias pacin="sudo pacman -S --needed"
alias pacinse="sudo pacman -S --asexplicit"

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
