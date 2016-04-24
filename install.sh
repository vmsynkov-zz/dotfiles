#!/bin/bash

TEMP_DIR=$HOME/temp

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
cd $TEMP_DIR
curl -s -o "$1".tar.gz https://aur.archlinux.org/cgit/aur.git/snapshot/"$1".tar.gz

if ! file "$1".tar.gz | grep gzip > /dev/null; then
	fatal "Failed downloading $ snapshot"
	exit 1
else
	tar -xf "$1".tar.gz
	cd $1
	makepkg --noconfirm --noprogressbar --needed -sri &> /dev/null
	eval "$2" > /dev/null && ok "Succesfully installed $1"
	cd $HOME
fi
}

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
xorg-xrdb"

AURPACKAGES="\
i3-gaps-next-git \
i3blocks-gaps-git \
canto-curses \
canto-daemon \
gtk-theme-arc \
numix-circle-icon-theme-git"

printf "Checking packages for existance...\n"
for pac in $PACKAGES; do
if pacman -Si $pac &> /dev/null; then
OK_PACLIST=$OK_PACLIST" $pac"
else
BAD_PACLIST=$BAD_PACLIST" $pac"
fi
done

printf "Installing found packages...\n"
sudo pacman  --noprogressbar --needed --noconfirm -Syu $OK_PACLIST &> /dev/null
ok "Pacman finished installing packages"

if [[ -n $BAD_PACLIST ]]; then
for pac in $BAD_PACLIST; do
warning "Couldn't find $pac\n"
done
fi

mkdir -p $TEMP_DIR
aurinstall cower-git "cower -V"

if [ "$?" = "0" ]; then
aurinstall pacaur "pacaur -V"
else 
fatal "Failed installing cower(pacaur dep)\n"
exit 1
fi

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

printf "Cloning Oh-My-Zsh\n"
rm -rf $HOME/.config/oh-my-zsh
env git clone --quiet --depth=1 https://github.com/robbyrussell/oh-my-zsh $HOME/.config/oh-my-zsh || {
	warning "Cloning Oh-My-Zsh failed"
}
[[ -d $HOME/.config/oh-my-zsh ]] && ok "Oh-My-Zsh installed"

printf "Cloning Powerlevel9k\n"
if [ -d $HOME/.config/oh-my-zsh/custom/themes/powerlevel9k ]; then
	ok "Powerlevel9k installed"
else
	env git clone --quiet --depth=1 https://github.com/bhilburn/powerlevel9k $HOME/.config/oh-my-zsh/custom/themes/powerlevel9k || {
	warning "Cloning Powerlevel9k failed"
}
fi

printf "Cloning dotfiles\n"

rm -rf $HOME/src/dotfiles
env git clone --quiet https://www.github.com/vmsynkov/dotfiles $HOME/src/dotfiles || {
	fatal "Cloning dotfiles failed"
	exit 1
}

[[ ! -d $HOME/src/dotfiles ]] && fatal "Cloning failed\n" && exit 1

GIT_LOCATION=$HOME/src/dotfiles
FONT_FOLDER=$HOME/.local/share/fonts
CONFIG_FOLDER=$HOME/.config
OHMYZSH=$HOME/.config/oh-my-zsh
SYSTEMD=$HOME/.config/systemd/user

printf "Linking XDG_CONFIG_DIRECTORY\n"
mkdir -p $CONFIG_FOLDER

[[ ! -d $HOME/.config/oh-my-zsh/custom ]] && mkdir -p $HOME/.config/oh-my-zsh/custom

if [ -d $HOME/.config/oh-my-zsh ]; then
	for entry in $(ls --almost-all $GIT_LOCATION/config/oh-my-zsh/custom); do 
	rm -f $OHMYZSH/custom/$entry
	ln -s $GIT_LOCATION/config/oh-my-zsh/custom/$entry $OHMYZSH/custom/$entry
	done
else 
	warning "Install Oh-My-Zsh first"
fi

printf "Installing systemd user services and timers\n"
mkdir -p $SYSTEMD

for entry in $(ls --almost-all $GIT_LOCATION/config/systemd/user); do 
	if [ ! -a $SYSTEMD/$entry ]; then
	install -m 0644 -p -t $SYSTEMD $GIT_LOCATION/config/systemd/user/$entry
	fi
done

printf "Linking wallpapers\n"
rm -rf $CONFIG_FOLDER/wallpapers
ln -s $GIT_LOCATION/config/wallpapers $CONFIG_FOLDER/wallpapers

for entry in $(ls --almost-all $GIT_LOCATION/config --ignore oh-my-zsh --ignore wallpapers --ignore nvim --ignore systemd); do 
	if [ -d $GIT_LOCATION/config/$entry ]; then
		mkdir -p $CONFIG_FOLDER/$entry
		for file in $(ls --almost-all $GIT_LOCATION/config/$entry); do
			rm -f $CONFIG_FOLDER/$entry/$file
			ln -s $GIT_LOCATION/config/$entry/$file $CONFIG_FOLDER/$entry/$file
		done

	else
	rm -f $CONFIG_FOLDER/$entry
	ln -s $GIT_LOCATION/config/$entry $CONFIG_FOLDER/$entry
	fi
done

printf "Installing patched fonts\n"
mkdir -p $FONT_FOLDER

for font in $(ls --almost-all $GIT_LOCATION/fonts); do
	if [ ! -a $FONT_FOLDER/$font ]; then
	install -m 0644 -p -t $FONT_FOLDER $GIT_LOCATION/fonts/$font
	fi
done
fc-cache -f $FONT_FOLDER

printf "Linking scripts\n"
rm -f $HOME/src/scripts
ln -s $GIT_LOCATION/scripts $HOME/src/scripts

printf "Installing zshenv and oblogout.conf"
install -m 0644 -p -t /etc $GIT_LOCATION/oblogout.conf
install -m 0644 -p -t /etc/zsh $GIT_LOCATION/zshenv

printf "Configuring vim\n"
[[ ! -d $HOME/.vim ]] && mkdir -p $HOME/.vim
rm -f $HOME/.vim/vimrc
ln -s $GIT_LOCATION/vim/vimrc $HOME/.vim/vimrc
for folder in $(ls --almost-all $GIT_LOCATION/vim); do
[[ -d $GIT_LOCATION/$folder ]] && cp -r $GIT_LOCATION/vim/$folder $HOME/.vim
done

BASE_DIRS="\
$HOME/doc \
$HOME/vid \
$HOME/pic \
$HOME/desk \
$HOME/muse \
$HOME/.local/.templates \
$HOME/.local/.public \
$HOME/.local/share/zsh \
$HOME/load \
$HOME/load/.tfiles \
$HOME/load/.tpart"

printf "Making base and XDG_USER_DIRS\n"
for dir in $BASE_DIRS; do
	mkdir -p $dir
done

xdg-user-dirs-update

printf "Cleaning up\n"
rm -rf $TEMP_DIR $HOME/.viminfo $HOME/.bash*

[[ ! "$(cat /etc/passwd | grep cli3mo | tail -c4)" = "zsh" ]] && chsh -s /bin/zsh cli3mo
