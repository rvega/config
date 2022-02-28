UNAME := $(shell uname -s)

install:
	yay -S zsh-completions-git zsh
	#chsh -s /bin/zsh
	ln -sf ${HOME}/Config/zsh/zgen ~/.zgen 2>/dev/null
	ln -sf ${HOME}/Config/zsh/zshrc ~/.zshrc 2>/dev/null
	zsh -i -c "zgen update"

