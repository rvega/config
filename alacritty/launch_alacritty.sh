#! /bin/bash

ICON="/home/rvg/Config/icons/Alacritty.png"        


if [ $# != 0 ]; then
  alacritty --working-directory $@ &
else 
  alacritty &
fi

sleep 1
activeWinLine=$(xprop -root | grep "_NET_ACTIVE_WINDOW(WINDOW)")
activeWinId="${activeWinLine:40}"
xseticon -id "$activeWinId" "$ICON"


