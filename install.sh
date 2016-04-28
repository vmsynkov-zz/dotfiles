#!/bin/bash

PACKAGES="\
vifm \
dunst \
alsa-utils \
rofi \
oblogout \
compton \
apvlv \
openssh \
xf86-video-intel \
xf86-video-ati \
xorg-server \
xorg-xinit \
xorg-utils \
xorg-server-utils \
feh \
termite \
tmux \
zip \
unzip \
zsh \
zsh-completions \
zsh-syntax-highlighting \
transmission-cli \
transmission-remote-cli \
mpd \
ncmpcpp \
mpv \
git \
python \
xdg-user-dirs \
expac \
trojita \
libnotify \
chromium \
gconf \
nodejs \
npm \
python-neovim-git \
python2-neovim-git \
cmake \
xorg-xrdb"

AURPACKAGES="\
i3-gaps-next-git \
i3blocks-gaps-git \
canto-curses \
canto-daemon \
gtk-theme-arc \
python-powerline-git \
numix-circle-icon-theme-git"

TMP_DIR=$HOME/tmp
REPO_DIR=$HOME/src/dotfiles
FONT_DIR=$HOME/.local/share/fonts
CONFIG_DIR=$HOME/.config
OHMYZSH_DIR=$HOME/.config/oh-my-zsh
SYSTEMD_DIR=$HOME/.config/systemd/user

BASE_DIRS="\
"$TMP_DIR" \
"$FONT_DIR" \
"$CONFIG_DIR" \
"$SYSTEMD_DIR" \
$HOME/doc \
$HOME/vid \
$HOME/pic \
$HOME/desk \
$HOME/muse \
$HOME/.local/.templates \
$HOME/.local/.public \
$HOME/.local/share/zsh \
$HOME/.local/npm \
$HOME/load \
$HOME/load/.tfiles \
$HOME/load/.tpart"

RED="\033[0;31m"
GREEN="\033[0;32m"
ORANGE="\033[0;33m"
NC="\033[0m"

function ok {
	printf "[${GREEN}OK${NC}] $1\n"
}

function warning {
	printf "[${ORANGE}WARNING${NC}] $1\n"
}

function fatal {
	printf "[${RED}FATAL${NC}] $1\n"
}

function aurinstall {
  pushd $TMP_DIR

  curl -s -o "$1".tar.gz https://aur.archlinux.org/cgit/aur.git/snapshot/"$1".tar.gz

  if ! file "$1".tar.gz | grep gzip > /dev/null; then
    fatal "Failed downloading $1 snapshot"
    exit 1
  else
    tar -xf "$1".tar.gz

    pushd $1
    makepkg --noconfirm --noprogressbar --needed -sri &> /dev/null
    popd

    which $2 &> /dev/null && ok "Succesfully installed $1" || fatal "$1 installation failed" && exit 1

    popd
  fi
}

printf "Constructing initial environment\n"
for dir in $BASE_DIRS; do
	mkdir -p $dir
done

printf "Checking packages for existance...\n"
for package in $PACKAGES; do
  if pacman -Si $package &> /dev/null; then
    OK_PACLIST=$OK_PACLIST" $package"
  else
    BAD_PACLIST=$BAD_PACLIST" $package"
  fi
done

printf "Installing found packages...\n"
sudo pacman  --noprogressbar --needed --noconfirm -Syu $OK_PACLIST &> /dev/null
ok "Pacman finished installing packages"

if [[ -n $BAD_PACLIST ]]; then
  for package in $BAD_PACLIST; do
    warning "Couldn't find $package\n"
  done
fi

aurinstall cower-git cower && aurinstall pacaur pacaur || warning "AUR packages won't be installed\n"

if which pacaur &> /dev/null; then
  printf "Checking AUR packages for existance...\n"
  for pac in $AURPACKAGES; do
    if pacaur -Sai $pac &> /dev/null; then
      OK_AURLIST=$OK_AURLIST" $pac"
    else
      BAD_AURLIST=$BAD_AURLIST" $pac"
    fi
  done

  printf "Installing found packages...\n"
  pacaur --noconfirm --noedit --needed -Sua $OK_AURLIST &> /dev/null
  ok "Pacaur finished installation"

  if [[ -n $BAD_AURLIST ]]; then
    for pac in $BAD_AURLIST; do
      warning "Couldn't find $pac\n"
    done
  fi
fi

printf "Cloning Oh-My-Zsh\n"
[[ -d $HOME/.config/oh-my-zsh ]] && ok "Oh-My-Zsh already installed" || {
  git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh $HOME/.config/oh-my-zsh &> /dev/null && ok "Oh-My-Zsh installed" || warning "Cloning Oh-My-Zsh failed"
}

printf "Cloning Powerlevel9k\n"
[[ -d $HOME/.config/oh-my-zsh ]] && {
  [[ -d $HOME/.config/oh-my-zsh/custom/themes/powerlevel9k ]] && ok "Powerlevel9k already installed" || 
	git clone --depth=1 https://github.com/bhilburn/powerlevel9k $HOME/.config/oh-my-zsh/custom/themes/powerlevel9k || warning "Cloning Powerlevel9k failed"
}

printf "Cloning dotfiles\n"
[[ -d $HOME/src/dotfiles ]] && ok "Dotfiles already cloned" || { 
  git clone https://www.github.com/vmsynkov/dotfiles $HOME/src/dotfiles &> /dev/null || fatal "Cloning dotfiles failed" && exit 1
}

printf "Linking XDG_CONFIG_HOME\n"

printf "Installing systemd user services and timers\n"
for entry in $(ls $REPO_DIR/config/systemd/user); do 
  [[ ! -a $SYSTEMD_DIR/$entry ]] && install -m 0644 -p -t $SYSTEMD_DIR $REPO_DIR/config/systemd/user/$entry
done

printf "Linking wallpapers\n"
[[ ! -a $CONFIG_DIR/wallpapers ]] && ln -s $REPO_DIR/config/wallpapers $CONFIG_DIR/wallpapers

printf "Linking configuration files\n"
for entry in $(ls $REPO_DIR/config --ignore wallpapers --ignore systemd); do 
	if [ -d $REPO_DIR/config/$entry ]; then
		mkdir -p $CONFIG_DIR/$entry
		for file in $(ls --almost-all $REPO_DIR/config/$entry); do
      [[ ! -a $CONFIG_DIR/$entry/$file ]] && ln -s $REPO_DIR/config/$entry/$file $CONFIG_DIR/$entry/$file
		done
	else
    [[ ! -a $CONFIG_DIR/$entry ]] && ln -s $REPO_DIR/config/$entry $CONFIG_DIR/$entry
	fi
done

printf "Installing patched fonts\n"
for font in $(ls $REPO_DIR/fonts); do
	[[ ! -a $FONT_DIR/$font ]] && install -m 0644 -p -t $FONT_DIR $REPO_DIR/fonts/$font
done

printf "Linking scripts\n"
[[ ! -a $HOME/src/scripts ]] && ln -s $REPO_DIR/scripts $HOME/src/scripts

printf "Installing /etc and /root specific files"
install -m 0644 -p -t /etc $REPO_DIR/oblogout.conf
install -m 0644 -p -t /etc/zsh $REPO_DIR/zshenv
sudo mkdir -p /root/.config /root/.local/share/zsh
[[ ! -a /root/.config/zsh ]] && sudo ln -s $REPO_DIR/config/zsh /root/.config/zsh
[[ ! -a /root/.config/nvim ]] && sudo ln -s $REPO_DIR/config/nvim /root/.config/nvim


printf "Cleaning up\n"
rm -rf $TMP_DIR $HOME/.viminfo $HOME/.bash*

printf "Some routines\n"
xdg-user-dirs-update
fc-cache -f $FONT_DIR
chsh -s /bin/zsh cli3mo
chsh -s /bin/zsh root
