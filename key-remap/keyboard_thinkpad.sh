#!/bin/bash

# To figure out the keycodes I used 
# `xmodmap -pke` and `xev`

# To figure out the "remove" lines, look at the output
# of `xmodmap`

# Read https://wiki.archlinux.org/index.php/Xmodmap

####

# Capslock as backslash
xmodmap -e "remove lock = Caps_Lock";
# xmodmap -e "keycode 66 = backslash"
xmodmap -e "keycode 66 = Control_R NoSymbol Control_R"

# PrintSc as Ctrl
xmodmap -e "keycode 107 = Control_R NoSymbol Control_R"
xmodmap -e "add control = Control_R"

