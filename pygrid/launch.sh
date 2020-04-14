#! /bin/bash

pid=`ps x | grep pygrid | grep -v grep | cut -d\  -f1`
kill $pid
src/pygrid.py
