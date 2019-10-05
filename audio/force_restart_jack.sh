#!/bin/sh

killall -9 jackdbus || true;
kill -9 `ps aux | grep cadence.py | grep -v grep | cut -d " " -f8` || true
cadence-session-start -s
setsid cadence &
sleep 1
