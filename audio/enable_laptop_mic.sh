#!/bin/sh

nohup zita-a2j -j mic -d hw:PCH,0 -r 44100 -p 1024 -n 3 -L &

amixer -c 0 set 'Capture' 0
sleep 1

amixer -c 0 set 'Capture' 78
amixer -c 0 set 'Mic Boost' 20

jack_connect mic:capture_1 system:playback_1
jack_connect mic:capture_2 system:playback_2

# jack_connect mic:capture_1 jack2alsa:playback_1
# jack_connect mic:capture_2 jack2alsa:playback_2

# jack_connect mic:capture_1 PulseAudio\ JACK\ Source:front-left
# jack_connect mic:capture_2 PulseAudio\ JACK\ Source:front-right
