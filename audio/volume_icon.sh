killall volumeicon;

if aplay -l | grep "USB Audio CODEC"; then
  nohup volumeicon --device="USB Audio CODEC" & 
else
  nohup volumeicon --device="HDA Intel PCH" &
fi

sleep 1
