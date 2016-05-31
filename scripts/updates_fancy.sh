#!/bin/bash

UPDATES_DUMP=$(checkupdates)
AUR_UPDATES_DUMP=$(pacaur -k)

[[ -n "$AUR_UPDATES_DUMP" ]] && AUR_UPDATES_NUM=$(echo "$AUR_UPDATES_DUMP" | wc -l) || AUR_UPDATES_NUM=0
[[ -n "$UPDATES_DUMP" ]] && UPDATES_NUM=$(echo "$UPDATES_DUMP" | wc -l) || UPDATES_NUM=0

UPDATES_PARSED=$(echo "$UPDATES_DUMP" | grep -E -o '([a-zA-Z]+[0-9]?+\-?)+\s')
AUR_UPDATES_PARSED=$( \
      for OUT in  $(echo "$AUR_UPDATES_DUMP" | cut -b 9- | grep -E -o '([a-zA-Z]+[0-9]?+\-?)+\s'); do
        echo "(AUR) $OUT";
      done)


if [ "$BLOCK_BUTTON" = "1" ]; then

  ROFI_ANSWER=$(echo -e "$AUR_UPDATES_PARSED\n""$UPDATES_PARSED" | rofi -dmenu -lines 15 -columns 2 -width 100 -p "updates avaliable: ")

	if [ -n "$ROFI_ANSWER" ]; then

		PASSWORD=$(rofi -dmenu -password -p "password: ")

		echo $PASSWORD | sudo -S pacaur -Syu --noconfirm &> /dev/null && \
		notify-send "Updates" "Upgrade finished" -i /usr/share/icons/Adwaita/48x48/emotes/face-devilish.png
	fi

	echo "    $UPDATES_NUM : $AUR_UPDATES_NUM "

elif [ "$UPDATES_NUM" = "0" && "AUR_UPDATES_NUM" = "0" ]; then echo "    OK! "
else echo "    $UPDATES_NUM : $AUR_UPDATES_NUM " && \
     notify-send "Updates" "\nPacman ${UPDATES_NUM}\nPacaur ${AUR_UPDATES_NUM}" -i /usr/share/icons/Adwaita/48x48/emotes/face-devilish.png
fi
