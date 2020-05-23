#! /bin/bash

pid=`ps x | grep pygrid | grep -v grep | cut -d\  -f4`
kill $pid
src/pygrid.py
