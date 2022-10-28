#!/usr/bin/env bash

# Get a screenshot
import -silent -window root /tmp/i3lock-gen.bmp

# Apply blur
convert /tmp/i3lock-gen.bmp -scale 25% -blur 0x7 -scale 400% /tmp/i3lock-blur.bmp
# convert /tmp/i3lock-gen.bmp -blur 0x2.5 /tmp/i3lock-blur.bmp

MONITOR_CNT=$(xrandr --current | grep "*" | wc -l)
if [[ $MONITOR_CNT == 2 ]] ; then
    PADLOCK="padlock_dual.bmp"
else
    PADLOCK="padlock.bmp"
fi

# Compose with padlock
convert /tmp/i3lock-blur.bmp $HOME/linux-config/lock/$PADLOCK -gravity center -composite /tmp/i3lock-final.png

i3lock -ef -i /tmp/i3lock-final.png

rm /tmp/i3lock-*.bmp
rm /tmp/i3lock-*.png

