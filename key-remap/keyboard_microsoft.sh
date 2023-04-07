#!/bin/bash

# To figure out the keycodes I used 
# `xmodmap -pke` and `xev`

# To figure out the "remove" lines, look at the output
# of `xmodmap`

# Read https://wiki.archlinux.org/index.php/Xmodmap

####

# Capslock as Ctrl 
setxkbmap -option ctrl:nocaps 
# xmodmap -e "remove lock = Caps_Lock" 2> /dev/null
# xmodmap -e "keycode 66 = Control_L NoSymbol Control_L"
# xmodmap -e "add control = Control_L"


# Right menu as Ctrl
xmodmap -e "keycode 135 = Control_R NoSymbol Control_R"
xmodmap -e "add control = Control_R"


# Key repetition delay.
gsettings set org.gnome.desktop.peripherals.keyboard delay 251
gsettings set org.gnome.desktop.peripherals.keyboard delay 250

