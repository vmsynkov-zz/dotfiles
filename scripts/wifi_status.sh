#!/bin/bash

QUALITY=$(grep wlp2s0 /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')

if [[ $QUALITY -ge 80 ]]; then
    echo " TOP"
elif [[ $QUALITY -lt 80 ]]; then
    echo " SUP"
elif [[ $QUALITY -lt 60 ]]; then
    echo " MID"
elif [[ $QUALITY -lt 40 ]]; then
    echo " BOT"
fi
