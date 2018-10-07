#!/bin/sh

beet lyrics -p $(mpc -f %artist% current) $(mpc -f %title% current) | head -n -4 > ~/.lyrics/lyric.txt

zenity --text-info --title='lyrics' --filename=$HOME/.lyrics/lyric.txt --width=600 --height=600 &