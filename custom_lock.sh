#!/bin/sh

ICON=$HOME/images/archActual.png
TMPBG=/tmp/screen.png
rm $TMPBG
scrot /tmp/screen.png
convert $TMPBG -blur 0x8 $TMPBG
#convert $TMPBG -scale 10% -scale 1000% $TMPBG
convert $TMPBG $ICON -gravity center -composite -matte $TMPBG
i3lock -i $TMPBG

