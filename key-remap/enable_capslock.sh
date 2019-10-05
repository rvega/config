#!/bin/bash

# To figure out the keycodes I used 
# `xmodmap -pke` and `xev`

# To figure out the "remove" lines, look at the output
# of `xmodmap`

# Read https://wiki.archlinux.org/index.php/Xmodmap

####

xmodmap -e "keycode 66 = Caps_Lock"
xmodmap -e "add lock = Caps_Lock";
