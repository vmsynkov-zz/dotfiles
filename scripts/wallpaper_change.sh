#!/bin/bash

LIST=$(ls $HOME/Config/wallpapers)
PAPER=$(echo $LIST | sed -e 's/\s\+/\n/g' | rofi -dmenu -format s)
WALL=$HOME/Config/wallpapers/$PAPER
LINE=$(grep -E -o -n '\w*\.jpg$' $HOME/.config/i3/config | head -c 1)
REGX=${LINE}s/.*/$PAPER/
sed -i "$REGX" $HOME/.config/i3/config
feh --bg-scale "$WALL"
