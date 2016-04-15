#################################################
## @TODO
## x deal with ln with existing folders problem
## x add installer for needed packages
#################################################

GIT_LOCATION=$PWD
FONT_FOLDER=$HOME/.local/share/fonts
CONFIG_FOLDER=$HOME/.config

echo [I] linking XDG_CONFIG_DIRECTORY
for folder in $(ls --almost-all config --ignore oh-my-zsh)
do 
#if [ ! -d folder ]; then
#mkdir -p $CONFIG_FOLDER/$folder
#fi

for file in $(ls --almost-all config/$folder)
do
ln -sf $GIT_LOCATION/config/$folder/$file $CONFIG_FOLDER/$folder/$file
done

done

echo [II] moving fonts
for font in $(ls --almost-all fonts)
do
install -m 0644 -p -t $FONT_FOLDER fonts/$font
done

echo [III] linking oh-my-zsh customs
for entry in $(ls --almost-all oh-my-zsh/custom)
do 
ln -sf $GIT_LOCATION/oh-my-zsh/custom/$entry $ZSH/custom/$entry
done

echo [IV] linking root level dotfiles
for file in $(ls --almost-all root)
do
ln -sf $GIT_LOCATION/root/$file $HOME/$file
done

echo [V] linking scripts
ln -sf $GIT_LOCATION/scripts $HOME/scripts

echo [VI] linking wallpapers
ln -sf $GIT_LOCATION/wallpapers $HOME/wallpapers
