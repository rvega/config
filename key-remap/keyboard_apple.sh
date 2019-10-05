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
    
# Right Alt as Ctrl
# xmodmap -e "remove mod1 = Alt_R"  #Works for gnome, cinnamon
xmodmap -e "remove mod5 = ISO_Level3_Shift"  #Works for xfce
xmodmap -e "keycode 108 = Control_L NoSymbol Control_R"
xmodmap -e "add control = Control_R"
  
# Right command as AltGr
xmodmap -e "remove mod4 = Super_R"
# xmodmap -e "keycode 134 = Alt_R Meta_R ISO_Level3_Shift" # Gnome, Cinnamon
xmodmap -e "keycode 134 = ISO_Level3_Shift NoSymbol ISO_Level3_Shift" # XFCE
# xmodmap -e "add mod5 = ISO_Level3_Shift" # XFCE?
