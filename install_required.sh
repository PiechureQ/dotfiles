#!/bin/sh

stow
nvim
tmux
  # git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
kitty
  #curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

fish

# fzf
git clone --depth 2 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

ripgrep

# nerdfonts
curl -fsSL https://raw.githubusercontent.com/getnf/getnf/main/install.sh | bash

sway
# required tools
xlpolkit
nmtui
# runner
rofi wayland fork
# topbar
waybar
swaylock
swayidle
# tools
wdisplays




