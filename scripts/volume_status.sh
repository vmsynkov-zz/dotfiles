#!/usr/bin/env bash

IS_MUTED=$(amixer get Master | tail -n1 | grep -E -o '\[\w{1,3}\]' | sed 's/[][]//g')

if [ $IS_MUTED == "on" ]; then
	echo $(amixer get Master | tail -n1 | grep -E -o '[0-9]{1,3}?%')
else
	echo Muted
fi
