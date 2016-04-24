alias tnrc='transmission-remote-cli'
alias tnra='transmission-remote -a'

alias dot='cd $HOME/src/dotfiles'

alias cu='checkupdates'

alias xpac='expac -H M "%011m\t%-20n\t%10d" $(comm -23 <(pacman -Qqen | sort) <(pacman -Qqg base base-devel | sort)) | sort -n'

alias zshrc='$EDITOR $XDG_CONFIG_HOME/zsh/.zshrc'
alias i3c='$EDITOR $XDG_CONFIG_HOME/i3/config'
alias i3b='$EDITOR $XDG_CONFIG_HOME/i3blocks/config'
alias tec='$EDITOR $XDG_CONFIG_HOME/termite/config'
alias gt3c='$EDITOR $XDG_CONFIG_HOME/gtk-3.0/settings.ini'
alias gt2c='$EDITOR $XDG_CONFIG_HOME/gtkrc-2.0/gtkrc'
alias xinc='$EDITOR $XDG_CONFIG_HOME/xorg/xinitrc'
alias xrec='$EDITOR $XDG_CONFIG_HOME/xorg/xresources'
alias tmuc='$EDITOR $XDG_CONFIG_HOME/tmux/tmux.conf'
alias npmc='$EDITOR $XDG_CONFIG_HOME/npm/npmrc'
alias vifc='$EDITOR $XDG_CONFIG_HOME/vifm/vifmrc'
alias vimc='$EDITOR $HOME/.vim/vimrc'
alias nvrc='$EDITOR $XDG_CONFIG_HOME/nvim/init.vim'

alias alic='$EDITOR $XDG_CONFIG_HOME/oh-my-zsh/custom/aliases.zsh'
alias powc='$EDITOR $XDG_CONFIG_HOME/oh-my-zsh/custom/powerlevel.zsh'

alias yt='mpsyt'

alias s='source'
alias sa='source $XDG_CONFIG_HOME/oh-my-zsh/custom/aliases.zsh'
alias sz='source $XDG_CONFIG_HOME/zsh/.zshrc'

alias h='cd $HOME'
alias load='cd $HOME/load'
alias doc='cd $HOME/doc'
alias muse='cd $HOME/muse'
alias vid='cd $HOME/vid'
alias pic='cd $HOME/pic'

alias lsa='ls --almost-all'
alias lx='ls -lXB' #  Sort by extension.
alias lk='ls -lSr' #  Sort by size, biggest last.
alias lt='ls -ltr' #  Sort by date, most recent last.
alias lc='ls -ltcr' #  Sort by/show change time,most recent last.
alias lu='ls -ltur' #  Sort by/show access time,most recent last.
alias lsd="ls -lv --group-directories-first"

alias feh="feh -g 900x500 --zoom max -x -d -B black"
alias tmux="tmux -f "$XDG_CONFIG_HOME"/tmux/tmux.conf"
alias apvlv="apvlv -c "$XDG_CONFIG_HOME"/apvlv/apvlvrc"
alias v='nvim'
