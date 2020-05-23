#!/bin/bash
#
# ctrl-alt-vim - a fork of vim-anywhere

# Original vim-anywhere
# Author: Chris Knadler
# Homepage: https://www.github.com/cknadler/vim-anywhere

# Open a temporary file with Vim. 
# When closed copy the contents to the system clipboard
# Remove temporary file

TMPFILE_DIR="$(mktemp -d /tmp/ctrl-alt-vim.XXX)"
TMPFILE="${TMPFILE_DIR}/vim-$(date +"%y%m%d%H%M%S").md"
touch ${TMPFILE}

# Removes all temp files on exit and sigint
function remove_tmp_dir() {
  rm -rf $TMPFILE_DIR
}
trap "remove_tmp_dir" EXIT SIGINT

chmod o-r $TMPFILE 
alacritty -e /usr/bin/nvim -s /home/Rafa/config/neovim/vimpaste $TMPFILE
cat $TMPFILE | xclip -selection clipboard
remove_tmp_dir

