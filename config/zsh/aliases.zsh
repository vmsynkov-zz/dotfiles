alias -g hl='--help | less' 
alias -g le='| less' 

alias pacin="sudo pacman -S --needed"
alias pacinse="sudo pacman -S --asexplicit"

alias tnrc='transmission-remote-cli'
alias tnra='transmission-remote -a'

alias dot='cd $HOME/src/dotfiles'

alias cu='checkupdates'

alias xpac='expac -H M "%011m\t%-20n\t%10d" $(comm -23 <(pacman -Qqen | sort) <(pacman -Qqg base base-devel | sort)) | sort -n'

alias zrc='$EDITOR $XDG_CONFIG_HOME/zsh/.zshrc'
alias i3c='$EDITOR $XDG_CONFIG_HOME/i3/config'
alias i3b='$EDITOR $XDG_CONFIG_HOME/i3blocks/config'
alias tec='$EDITOR $XDG_CONFIG_HOME/termite/config'
alias g3c='$EDITOR $XDG_CONFIG_HOME/gtk-3.0/settings.ini'
alias g2c='$EDITOR $XDG_CONFIG_HOME/gtkrc-2.0/gtkrc'
alias xic='$EDITOR $XDG_CONFIG_HOME/xorg/xinitrc'
alias xrc='$EDITOR $XDG_CONFIG_HOME/xorg/xresources'
alias tmc='$EDITOR $XDG_CONFIG_HOME/tmux/tmux.conf'
alias npc='$EDITOR $XDG_CONFIG_HOME/npm/npmrc'
alias vfc='$EDITOR $XDG_CONFIG_HOME/vifm/vifmrc'
alias nvc='$EDITOR $XDG_CONFIG_HOME/nvim/init.vim'

alias alc='$EDITOR $XDG_CONFIG_HOME/zsh/aliases.zsh'
alias poc='$EDITOR $XDG_CONFIG_HOME/zsh/powerlevel.zsh'

alias yt='mpsyt'

alias s='source'
alias sa='source $XDG_CONFIG_HOME/zsh/aliases.zsh'
alias sz='source $XDG_CONFIG_HOME/zsh/.zshrc'

alias h='cd $HOME'
alias load='cd $HOME/load'
alias doc='cd $HOME/doc'
alias muse='cd $HOME/muse'
alias vid='cd $HOME/vid'
alias pic='cd $HOME/pic'

alias lsl='ls --almost-all'
alias lsx='ls -lXB'  # Sort by extension.
alias lss='ls -lSr'  # Sort by size, biggest last.
alias lsd='ls -ltr'  # Sort by date, most recent last.
alias lsc='ls -ltcr' # Sort by/show change time,most recent last.
alias lsa='ls -ltur' # Sort by/show access time,most recent last.
alias lsf="ls -lv --group-directories-first"

alias feh="feh -g 1800x950 --zoom max -x -d -B black"
alias tmux="tmux -f "$XDG_CONFIG_HOME"/tmux/tmux.conf"
alias apvlv="apvlv -c "$XDG_CONFIG_HOME"/apvlv/apvlvrc"
alias v='nvim'
alias vim='nvim'
