# keyboard customizations.

I'm using 3 types of keyboard configs. 

1. For the koolterton usb keyboard, there is a windoze config tool that allows for mappings.

2. For the laptop keyboard and the microsoft usb keyboard, I use the xmodmap util. See the .sh and .desktop files in this directory.

To figure out the keycodes I used 
`xmodmap -pke` and `xev`

To figure out the "remove" lines, look at the output
of `xmodmap`

Read https://wiki.archlinux.org/index.php/Xmodmap

3. For other things that xmodmap does not allow, I'm using a program called Autokey, `yay -S autokey-patched`. Make sure it starts at login. 


