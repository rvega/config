import subprocess 
keyboard.send_keys("<ctrl>+a")
keyboard.send_keys("<ctrl>+c")
subprocess.call(["/home/Rafa/config/neovim/ctrl-alt-vim.sh"], shell=True)
keyboard.send_keys("<ctrl>+v")