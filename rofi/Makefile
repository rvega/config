all:
	sudo pacman -S rofi
	cd adi1090x-rofi-repo && ./setup.sh
	sed 's/style-1/style-5/' -ibkp /home/vega/.config/rofi/launchers/type-1/launcher.sh
	ln -s /home/vega/Config/rofi/config.rasi /home/vega/.config/rofi/config.rasi

	#yay -S albert-minimal
	#ln -fs /home/rvg/Config/albert/albert.desktop ~/.local/share/applications
