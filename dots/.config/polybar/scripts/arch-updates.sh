#!/bin/sh

sleep 5
main=$(checkupdates | wc -l)
aur=$(trizen -Su --aur --quiet | wc -l)
updates=$((main + aur))


if [ "$updates" -gt 0 ]; then
	echo " $updates"
else
	echo ""
fi