#!/bin/bash
mkdir -p ../.config

if [[ -z $STOW_FOLDERS ]]; then
  STOW_FOLDERS="nvim,zsh,git" # To add more, simply insert a comma and then a program name (no whitespace)
fi

if [[ -z $DOT_FILES ]]; then
  DOTFILES=$HOME/dot_files # To add more, simply insert a comma and then a program name (no whitespace)
fi

STOW_FOLDERS=$STOW_FOLDERS DOTFILES=$DOTFILES ./install.sh
