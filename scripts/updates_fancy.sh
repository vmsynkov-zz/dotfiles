#!/bin/bash

if [ "$BLOCK_BUTTON" = "2" ]; then
PASSWORD=$(rofi -dmenu -lines 1 -p "password: ")
echo $PASSWORD | sudo -S pacman -S iw --noconfirm &> /dev/null
fi

[[ "$BLOCK_BUTTON" = "3" ]] && echo "    $(checkupdates | wc -l) "

if [ "$BLOCK_BUTTON" = "1" ]; then
ANSWER=$(checkupdates | grep -E -o '([a-zA-Z]+[0-9]?+\-?)+\s' | rofi -dmenu -lines 15 -columns 2 -width 100 -p "updates avaliable: ")

if [ -n "$ANSWER" ]; then
PASSWORD=$(rofi -dmenu -lines 1 -p "password: ")
echo $PASSWORD | sudo -S pacman -Syu --noconfirm &> /dev/null
fi

fi

echo "    $(checkupdates | wc -l) "
