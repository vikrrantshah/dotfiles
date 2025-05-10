#!/bin/bash

BREW=$(which brew)

if [ "$BREW" = "brew not found" ]; then
  echo "Homebrew not installed please install homebrew"
  exit 1
fi

INSTALLED=()

GHOSTTY=$(which ghostty)

if [ "$GHOSTTY" = "ghostty not found" ]; then
  brew install --cask ghostty
  INSTALLED+=("Ghostty")
fi

NVIM=$(which nvim)

if [ "$NVIM" = "nvim not found" ]; then
  brew install neovim
  INSTALLED+=("NeoVim")
fi

TMUX=$(which tmux)

if [ "$TMUX" = "tmux not found" ]; then
  brew install tmux
  INSTALLED+=("Tmux")
fi

TMPLOCATION="$HOME/.tmux/plugins/tpm"

if [ ! -d "$TMPLOCATION" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  INSTALLED+=("Tmux Plugin Manager")
fi

echo ""
for tool in "${INSTALLED[@]}"; do
  echo "Installed $tool"
done
echo ""

chmod +x ./tmux/tmux-sessionizer/main.sh
