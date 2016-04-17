#!/bin/bash

if [ "$BLOCK_BUTTON" = "1" ]; then
	ANSWER=$(checkupdates | grep -E -o '([a-zA-Z]+[0-9]?+\-?)+\s' | rofi -dmenu -lines 15 -columns 2 -width 100 -p "updates avaliable: ")
	if [ -n "$ANSWER" ]; then
		PASSWORD=$(rofi -dmenu -lines 1 -p "password: ")
		echo $PASSWORD | sudo -S pacman -Syu --noconfirm &> /dev/null\
		&& notify-send "Pacman" "Updates installed" -i /usr/share/icons/Adwaita/48x48/emotes/face-devilish.png && echo "    OK "
	elif [ "$(Z=checkupdates | wc -l)" = "0" ]; then
	       	echo "    OK "
	else
	echo "    $Z " && notify-send "Pacman" "${Z} new updates" -i /usr/share/icons/Adwaita/48x48/emotes/face-devilish.png
	fi
elif [ "$(Z=checkupdates | wc -l)" = "0" ]; then
       	echo "    OK "
else
	echo "    $Z " && notify-send "Pacman" "${Z} new updates" -i /usr/share/icons/Adwaita/48x48/emotes/face-devilish.png
fi
