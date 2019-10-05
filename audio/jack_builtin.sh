#!/bin/bash

setsid cadence &
jack_control stop
cp ~/Config/audio/conf-builtin.xml ~/.config/jack/conf.xml
sleep 2
systemctl --user mask pulseaudio.socket
pulseaudio --kill
# pkill pasystray
# echo "autospawn = no" > ~/.pulse/client.conf
cadence-session-start -s
# alsactl -L restore
sleep 1
