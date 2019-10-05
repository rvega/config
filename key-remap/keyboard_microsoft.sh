#!/bin/bash

# To figure out the keycodes I used 
# `xmodmap -pke` and `xev`

# To figure out the "remove" lines, look at the output
# of `xmodmap`

# Read https://wiki.archlinux.org/index.php/Xmodmap

####

# Capslock as backtick (grave)
xmodmap -e "remove lock = Caps_Lock";
xmodmap -e "keycode 66 = grave"

# Left Super (Windows) as Alt  (*)
# xmodmap -e "remove mod4 = Super_L Hyper_L"
# xmodmap -e "keycode 133 = Alt_L Meta_L Alt_L Meta_L"

# Left Alt as Super (Windows)
# xmodmap -e "remove mod1 = Alt_L Meta_L"
# xmodmap -e "keycode 64 = Super_L NoSymbol Super_L"

# Right menu as Ctrl
xmodmap -e "keycode 135 = Control_R NoSymbol Control_R"

# xmodmap -e "add mod1 = Alt_L Meta_L"
# xmodmap -e "add mod4 = Super_L Hyper_L"
xmodmap -e "add control = Control_R"
