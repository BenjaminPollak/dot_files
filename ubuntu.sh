#!/bin/bash
if [[ -z $STOW_FOLDERS ]]; then
  STOW_FOLDERS="nvim"
fi

STOW_FOLDERS=$STOW_FOLDERS DOTFILES=$DOTFILES ./install.sh
