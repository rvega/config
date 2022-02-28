#! /bin/bash

pid=`ps x | grep pygrid | grep -v grep | cut -d\  -f4`
kill $pid
sleep 1
/home/Rafa/config/pygrid/src/pygrid.py 
sleep 10

