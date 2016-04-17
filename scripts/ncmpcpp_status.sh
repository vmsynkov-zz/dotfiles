#!/usr/bin/bash

if mpc | grep playing > /dev/null; then
	echo " $(ncmpcpp --current-song | grep -E -o '(\w+\s?)+\-\s\w+') "
else 
	echo "Idle "
fi
