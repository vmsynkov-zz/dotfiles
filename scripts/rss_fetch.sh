#!/usr/bin/env bash

FEED=$(canto-remote status)
[[ "${FEED}" = "0" ]] && exit 0
pkill -RTMIN+3 i3blocks
