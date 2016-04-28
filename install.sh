#!/bin/bash

PACKAGES="\
alsa-utils \
apvlv \
chromium \
cmake \
compton \
dunst \
expac \
feh \
gconf \
git \
libnotify \
mpd \
mpv \
ncmpcpp \
nodejs \
npm \
oblogout \
openssh \
python \
python2 \
python-neovim \
python2-neovim \
rofi \
termite \
tmux \
transmission-cli \
transmission-remote-cli \
trojita \
unzip \
vifm \
xdg-user-dirs \
xf86-video-ati \
xf86-video-intel \
xorg-server \
xorg-server-utils \
xorg-utils \
xorg-xinit \
xorg-xrdb \
zip \
zsh \
zsh-completions \
zsh-syntax-highlighting"

[[ "$1" = "vbox" ]] && PACKAGES=$PACKAGES" linux-headers virtualbox-guest-utils"

AURPACKAGES="\
canto-curses \
canto-daemon \
gtk-theme-arc \
i3-gaps-next-git \
i3blocks-gaps-git \
numix-circle-icon-theme-git \
python-powerline-git"

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
$HOME/.local/share/tmux \
$HOME/.local/share/npm \
$HOME/load \
$HOME/load/.tfiles \
$HOME/load/.tpart"

RED="\033[0;31m"
GREEN="\033[0;32m"
ORANGE="\033[0;33m"
PINK="\033[0;35m"
NC="\033[0m"

function ok {
  printf "[${GREEN}OK${NC}] $1\n"
}

function warning {
  printf "[${ORANGE}WARNING${NC}] $1\n" | tee -a install.log
}

function fatal {
  printf "[${RED}FATAL${NC}] $1\n"
}

function step {
  printf "[${PINK}**${NC}] $1\n"
}

function aurinstall {
  pushd $TMP_DIR &> /dev/null

  curl -s -o "$1".tar.gz https://aur.archlinux.org/cgit/aur.git/snapshot/"$1".tar.gz

  if ! file "$1".tar.gz | grep gzip > /dev/null; then
    fatal "Failed downloading $1 snapshot"
    exit 1
  else
    tar -xf "$1".tar.gz

    pushd $1 &> /dev/null
    makepkg --noconfirm --noprogressbar --needed -sri &> /dev/null
    popd &> /dev/null

    which $2 &> /dev/null && ok "Succesfully installed $1" && popd &> /dev/null || {
      fatal "$1 installation failed" && exit 1
      }
  fi
}

step "Constructing initial environment"
for dir in $BASE_DIRS; do
  mkdir -p $dir
done

step "Checking packages for existance..."
for package in $PACKAGES; do
  if pacman -Si $package &> /dev/null; then
    OK_PACLIST=$OK_PACLIST" $package"
  else
    BAD_PACLIST=$BAD_PACLIST" $package"
  fi
done

step "Installing found packages..."
sudo pacman  --noprogressbar --needed --noconfirm -Syu $OK_PACLIST &> /dev/null
ok "Pacman finished installing packages"

if [[ -n $BAD_PACLIST ]]; then
  for package in $BAD_PACLIST; do
    warning "Couldn't find $package\n"
  done
fi

aurinstall cower-git cower && { 
  aurinstall pacaur pacaur && {
    step "Checking AUR packages for existance..."
    for pac in $AURPACKAGES; do
      if pacaur -Sai $pac &> /dev/null; then
        OK_AURLIST=$OK_AURLIST" $pac"
      else
        BAD_AURLIST=$BAD_AURLIST" $pac"
      fi
    done

    step "Installing found packages..."
    pacaur --noconfirm --noedit --needed -Sua $OK_AURLIST &> /dev/null
    ok "Pacaur finished installation"

    if [[ -n $BAD_AURLIST ]]; then
      for pac in $BAD_AURLIST; do
        warning "Couldn't find $pac\n"
      done
    fi
  }
} || warning "AUR packages won't be installed\n"

step "Cloning Oh-My-Zsh"
git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh $HOME/.config/oh-my-zsh &> /dev/null && ok "Oh-My-Zsh installed" || warning "Cloning Oh-My-Zsh failed"

step "Cloning Powerlevel9k"
[[ -d $HOME/.config/oh-my-zsh ]] && \
git clone --depth=1 https://github.com/bhilburn/powerlevel9k $HOME/.config/oh-my-zsh/custom/themes/powerlevel9k &> /dev/null || warning "Cloning Powerlevel9k failed"

step "Cloning dotfiles"
git clone https://www.github.com/vmsynkov/dotfiles $HOME/src/dotfiles &> /dev/null || { 
  fatal "Cloning dotfiles failed" && exit 1 
}

step "Installing systemd user services and timers"
for entry in $(ls $REPO_DIR/config/systemd/user); do 
  install -m 0644 -p -t $SYSTEMD_DIR $REPO_DIR/config/systemd/user/$entry
done

step "Linking wallpapers"
ln -s $REPO_DIR/config/wallpapers $CONFIG_DIR/wallpapers

step "Linking configuration files"
for entry in $(ls $REPO_DIR/config --ignore wallpapers --ignore systemd); do 
  if [ -d $REPO_DIR/config/$entry ]; then
    mkdir -p $CONFIG_DIR/$entry
    for file in $(ls --almost-all $REPO_DIR/config/$entry); do
      ln -s $REPO_DIR/config/$entry/$file $CONFIG_DIR/$entry/$file
    done
  else
    ln -s $REPO_DIR/config/$entry $CONFIG_DIR/$entry
  fi
done

step "Installing patched fonts"
for font in $(ls $REPO_DIR/fonts); do
  install -m 0644 -p -t $FONT_DIR $REPO_DIR/fonts/$font
done

step "Linking scripts"
ln -s $REPO_DIR/scripts $HOME/src/scripts

step "Installing oblogout.conf"
sudo install -m 0644 -p -t /etc $REPO_DIR/oblogout.conf
step "Installing zshenv"
sudo install -m 0644 -p -t /etc/zsh $REPO_DIR/zshenv
step "Linking zshrc for root"
sudo mkdir -p /root/.config /root/.local/share/zsh
sudo ln -s $REPO_DIR/config/zsh /root/.config/zsh

step "Installing vim plugins"
nvim -s $REPO_DIR/vimplug

step "XDG user-dirs update"
xdg-user-dirs-update

step "Font cache update"
fc-cache -f $FONT_DIR

step "Changing shell"
sudo chsh -s /bin/zsh cli3mo &> /dev/null
sudo chsh -s /bin/zsh root &> /dev/null

step "Changing dotfiles remote to ssh"
pushd $REPO_DIR &> /dev/null
git remote set-url origin git@github.com:vmsynkov/dotfiles
popd &> /dev/null

[[ "$1" = "vbox" ]] && step "Enabling vboxservice" && sudo systemctl enable vboxservice &> /dev/null

step "Cleaning up"
rm -rf $TMP_DIR $HOME/.bash*

reboot
