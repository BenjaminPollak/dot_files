#!/bin/bash
mkdir -p ../.config

if [[ -z $STOW_FOLDERS ]]; then
  STOW_FOLDERS="nvim" # To add more, simply insert a comma and then a program name (no whitespace)
fi

STOW_FOLDERS=$STOW_FOLDERS DOTFILES=$DOTFILES ./install.sh
