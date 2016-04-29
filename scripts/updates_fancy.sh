#!/bin/bash

UPDATES_DUMP=$(checkupdates)
[[ -n "$UPDATES_DUMP" ]] && UPDATES_NUM=$(echo "$UPDATES_DUMP" | wc -l) || UPDATES_NUM=0

if [ "$BLOCK_BUTTON" = "1" ]; then

	ANSWER=$(echo "$UPDATES_DUMP" | \
           grep -E -o '([a-zA-Z]+[0-9]?+\-?)+\s' | \
           rofi -dmenu -lines 15 -columns 2 -width 100 -p "updates avaliable: ")

	if [ -n "$ANSWER" ]; then

		PASSWORD=$(rofi -dmenu -password -p "password: ")

		echo $PASSWORD | sudo -S pacman -Syu --noconfirm &> /dev/null &&\
		notify-send "Pacman" "Updates installed" -i /usr/share/icons/Adwaita/48x48/emotes/face-devilish.png
	fi

	echo "    $UPDATES_NUM "

elif [ "$UPDATES_NUM" = "0" ]; then echo "    0 "
else echo "    $UPDATES_NUM " && \
     notify-send "Pacman" "${UPDATES_NUM} new updates" -i /usr/share/icons/Adwaita/48x48/emotes/face-devilish.png
fi
