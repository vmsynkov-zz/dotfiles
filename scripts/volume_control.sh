#!/usr/bin/env bash

if [ "$1" == "lower" ]; then
	amixer -q set Master 3%-
	pkill -RTMIN+1 i3blocks
elif [ "$1" == "increase" ]; then
	amixer -q set Master 3%+
	pkill -RTMIN+1 i3blocks
elif [ "$1" == "toggle" ]; then
	amixer -q set Master toggle
	pkill -RTMIN+1 i3blocks
fi
