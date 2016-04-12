alias trc='transmission-remote-cli'
alias tra='transmission-remote -a '

alias cu='checkupdates'

alias xpac='expac -H M "%011m\t%-20n\t%10d" $(comm -23 <(pacman -Qqen | sort) <(pacman -Qqg base base-devel | sort)) | sort -n'

alias zshrc='vim $HOME/.config/zsh/.zshrc'
alias i3c='vim $HOME/.config/i3/config'
alias i3b='vim $HOME/.config/i3blocks/config'
alias tec='vim $HOME/.config/termite/config'
alias gt3c='vim $HOME/.config/gtk-3.0/settings.ini'
alias gt2c='vim $HOME/.gtkrc-2.0'
alias xinc='vim $HOME/.xinitrc'
alias xrec='vim $HOME/.Xresources'
alias vimc='vim $HOME/.vimrc'
alias tmuc='vim $HOME/.tmux.conf'
alias npmc='vim $HOME/.npmrc'
alias vifc='vim $HOME/.config/vifm/vifmrc'
alias cmuc='vim $HOME/.config/cmus/rc'
alias alic='vim $HOME/.oh-my-zsh/custom/aliases.zsh'
alias powc='vim $HOME/.oh-my-zsh/custom/powerlevel.zsh'

alias yt='mpsyt'

alias c='clear'
alias e='exit'

alias s='source '
alias sa='source $HOME/.oh-my-zsh/custom/aliases.zsh'
alias sz='source $HOME/.zshrc'

alias h='cd $HOME'
alias load='cd $HOME/load'
alias doc='cd $HOME/doc'
alias mus='cd $HOME/muse'
alias vid='cd $HOME/vid'
alias src='cd $HOME/src'

alias lsa='ls --almost-all'
alias lx='ls -lXB' #  Sort by extension.
alias lk='ls -lSr' #  Sort by size, biggest last.
alias lt='ls -ltr' #  Sort by date, most recent last.
alias lc='ls -ltcr' #  Sort by/show change time,most recent last.
alias lu='ls -ltur' #  Sort by/show access time,most recent last.
alias lsd="ls -lv --group-directories-first"

alias feh="feh -g 900x500 --zoom max -x -d -B black"
alias ncmpcpp="ncmpcpp -c "$XDG_CONFIG_HOME"/ncmpcpp/config"
alias tmux="tmux -f "$XDG_CONFIG_HOME"/tmux/tmux.conf"
alias apvlv="apvlv -c "$XDG_CONFIG_HOME"/apvlv/apvlvrc"
