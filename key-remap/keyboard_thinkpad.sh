#!/bin/bash

# To figure out the keycodes I used 
# `xmodmap -pke` and `xev`

# To figure out the "remove" lines, look at the output
# of `xmodmap`

# Read https://wiki.archlinux.org/index.php/Xmodmap

####

# Capslock 
xmodmap -e "remove lock = Caps_Lock";
# xmodmap -e "keycode 66 = backslash"
xmodmap -e "keycode 66 = Control_L NoSymbol Control_L"

# PrintScreen
xmodmap -e "keycode 107 = Control_L NoSymbol Control_L"
xmodmap -e "add control = Control_L"

# Key repetition delay.
gsettings set org.gnome.desktop.peripherals.keyboard delay 251
gsettings set org.gnome.desktop.peripherals.keyboard delay 250
