win_class = window.get_active_class()
if win_class == 'org.gnome.Nautilus.Org.gnome.Nautilus':
    keyboard.send_keys("<ctrl>+l")
else:
    keyboard.send_keys("<delete>")