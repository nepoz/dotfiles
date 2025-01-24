#!/bin/sh
setxkbmap -option caps:escape &
nm-applet &
picom &
blueman-applet &
dunst &
eval $(/usr/bin/gnome-keyring-daemon --start --components=secrets) &
flameshot &
