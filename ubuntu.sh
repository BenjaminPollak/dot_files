#!/bin/bash
if [[ -z $STOW_FOLDERS ]]; then
  STOW_FOLDERS="nvim"
fi

if [[ -z $DOT_FILES ]]; then
  DOTFILES=$HOME/dot_files
fi

STOW_FOLDERS=$STOW_FOLDERS DOTFILES=$DOTFILES $DOTFILES/install.sh
