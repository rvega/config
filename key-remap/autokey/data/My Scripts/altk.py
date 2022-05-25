win_class = window.get_active_class()
if win_class == 'Alacritty.Alacritty':
    keyboard.send_keys("<alt>+k")
else:
    keyboard.send_keys("<up>")