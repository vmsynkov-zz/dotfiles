#!/usr/bin/env bash

UPDATES=$(checkupdates | wc -l)
[[ "${UPDATES}" = "0" ]] && exit 0
pkill -RTMIN+2 i3blocks
