#!/usr/bin/env sh

xrandr --output DP-3 --mode 1920x1080 --rate 144
picom -b --backend  glx
xbindkeys
