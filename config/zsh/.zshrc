export ZSH=$HOME/.config/oh-my-zsh

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/.local/bin/:$HOME/.local/npm-global/bin"
export TERM="xterm-256color"
export EDITOR="nvim"
export ARCHFLAGS="-arch x86_64"
export SSH_KEY_PATH="$HOME/.ssh/id_rsa"

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export XAUTHORITY=$XDG_CONFIG_HOME/xorg/xauthority
export SCRIPTS_FOLDER=$HOME/src/scripts
export GTK2_RC_FILES=$XDG_CONFIG_HOME/gtk-2.0/gtkrc
export TMUX_TMPDIR=$XDG_RUNTIME_DIR/tmux
export npm_config_userconfig=$XDG_CONFIG_HOME/npm/npmrc
export LESSHISTFILE=/dev/null
export GNUPGHOME=$XDG_DATA_HOME/gnupg
export SSH_KEY_PATH=$XDG_DATA_HOME/ssh/id_rsa

plugins=(sudo archlinux extract)

ZSH_THEME="powerlevel9k/powerlevel9k"

#setopt appendhistory autocd beep extendedglob nomatch notify
#setopt noautopushd chasedots chaselinks pushdtohome pushdsilent beep

DISABLE_AUTO_UPDATE="true"

HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"

alias pacin="sudo pacman -S --needed"
alias pacinse="sudo pacman -S --asexplicit"

function ns {
  touch $1 && chmod u+x $1 && $EDITOR $1
}

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx $HOME/.config/xorg/xinitrc; :
