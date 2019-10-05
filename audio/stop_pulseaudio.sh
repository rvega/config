#!/bin/bash

systemctl --user mask pulseaudio.socket
pulseaudio --kill
sleep 1


