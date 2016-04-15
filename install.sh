GIT_LOCATION=$PWD
FONT_FOLDER=$HOME/.local/share/fonts
CONFIG_FOLDER=$HOME/.config
OHMYZSH=$HOME/.config/oh-my-zsh

echo [I] linking XDG_CONFIG_DIRECTORY
mkdir -p $CONFIG_FOLDER

#assuming oh-my-zsh is installed by the prior script
for entry in $(ls --almost-all config/oh-my-zsh/custom)
do 
rm -f $OHMYZSH/custom/$entry
ln -s $GIT_LOCATION/config/oh-my-zsh/custom/$entry $OHMYZSH/custom/$entry
done

rm -rf $CONFIG_FOLDER/wallpapers
ln -s $GIT_LOCATION/config/wallpapers $CONFIG_FOLDER/wallpapers

for entry in $(ls --almost-all config --ignore oh-my-zsh --ignore wallpapers --ignore nvim); do 
if [ -d config/$entry ]; then
mkdir -p $CONFIG_FOLDER/$entry
for file in $(ls --almost-all config/$entry); do
rm -f $CONFIG_FOLDER/$entry/$file
ln -s $GIT_LOCATION/config/$entry/$file $CONFIG_FOLDER/$entry/$file
done

else
rm -f $CONFIG_FOLDER/$entry
ln -s $GIT_LOCATION/config/$entry $CONFIG_FOLDER/$entry
fi
done

echo [II] moving fonts
mkdir -p $FONT_FOLDER
for font in $(ls --almost-all fonts)
do
if [ ! -a $FONT_FOLDER/$font ]; then
install -m 0644 -p -t $FONT_FOLDER fonts/$font
fi
done

echo [III] linking scripts
rm -f $HOME/src/scripts
ln -s $GIT_LOCATION/scripts $HOME/src/scripts
