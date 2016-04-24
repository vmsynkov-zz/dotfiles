#!/usr/bin/env bash

LAYOUT=$(setxkbmap -query | awk '
	BEGIN{layout=""}
	/^layout/{layout=$2}
	END{printf("%s",layout)}')

if [ $LAYOUT = 'us' ]; then
	setxkbmap -layout ru -option terminate:ctrl_alt_bksp -option caps:swapescape -option ctrl:swap_lalt_lctl
elif [ $LAYOUT = 'ru' ]; then
	setxkbmap -layout us -option terminate:ctrl_alt_bksp -option caps:swapescape -option ctrl:swap_lalt_lctl
fi

xmodmap -e "keycode 135 = Super_L"

pkill -RTMIN+4 i3blocks
