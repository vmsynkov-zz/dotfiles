#!/usr/bin/env bash

FEED=$(canto-remote status)
[[ "${FEED}" = "0" ]] && exit 0

echo " ${FEED} "
exit 0
