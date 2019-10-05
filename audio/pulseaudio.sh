#!/bin/bash

# jack_control stop
# sleep 2
# kill -9 `ps aux | grep cadence.py | grep -v grep | cut -d " " -f8` || true
# rm ~/.pulse/*
# echo "autospawn = yes" > ~/.pulse/client.conf

jack_control stop 
sleep 3
rm ~/.pulse/*
systemctl --user unmask pulseaudio.socket
pulseaudio --kill
pulseaudio --start
sleep 1
# alsactl -L restore
# setsid pasystray &
# sleep 1


