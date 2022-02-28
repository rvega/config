all:
	#yay -S thinkfan
	# sudo cp -f /home/Rafa/config/thinkpad-fans/thinkfan.conf /etc/thinkfan.conf
	sudo cp -f /home/Rafa/config/thinkpad-fans/override.conf /etc/systemd/system/thinkfan.service.d/override.conf
	sudo systemctl disable fancontrol.service
	sudo systemctl stop fancontrol.service
	sudo systemctl enable thinkfan.service
	sudo systemctl start thinkfan.service
