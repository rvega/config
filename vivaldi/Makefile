install:
	cp vivaldi-cookies.* /etc/systemd/system
	systemctl daemon-reload
	systemctl start vivaldi-cookies.timer
	systemctl enable vivaldi-cookies.timer
	systemctl list-timers --all

