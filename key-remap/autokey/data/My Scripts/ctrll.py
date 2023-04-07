win_class = window.get_active_class()

exceptions = [
 'org.gnome.Nautilus.Org.gnome.Nautilus',
 'google-chrome.Google-chrome',
 'chromium.Chromium',
 'dolphin.dolphin'
]

if win_class in exceptions:
    keyboard.send_keys("<ctrl>+l")
else:
    keyboard.send_keys("<delete>")
