#!/bin/sh

#stow
#sudo apt install stow

#nvim
#https://github.com/neovim/neovim/releases

#kitty
#curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

#tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# https://github.com/tmux/tmux/releases

# fish
#sudo apt install fish

# fzf
git clone --depth 2 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# ripgrep (telescope and more)
# sudo apt install ripgrep

# nerdfonts
curl -fsSL https://raw.githubusercontent.com/getnf/getnf/main/install.sh | bash

