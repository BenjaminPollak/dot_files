# My Dotfiles

This repo is for tracking my dotfiles. It currently contains the following:

- Ansible Scripts (for quickly installing and configuring software on a new computer)
- Bash Config Scripts
- Git Configs
- Vim/Nvim Config

Config files are managed through GNU Stow.

Dockerfile and Makefile are included so I can test this setup easily.

# Prerequisites

- Machine has `docker` installed
- Machine has `make` installed

## For a Personal Machine

- Primary user account is named `benjamin`

## For a Work Machine

- Right now, the ansible script escalates privileges to while running. Manually delete the line `become: true` if running on a mac computer.

# Testing with Docker

Obviously you'll need docker installed. Then, follow the below instructions:

1. build the docker container by running `docker build .`
2. get the container ID by running `docker images`
3. run the container using `docker run -i -v ${PWD}:/home/ubuntu/dot_files -t <CONTAINER_ID> /bin/bash`
4. navigate to /home/ubuntu/dot_files in the container and execute `ansible-playbook desktop_config.yml`

# Per-Machine Configuration

I have made this possible in the following ways:

- for Z-Shell:
  - put config in `~/local.zsh`
- for Git:
  - if on a work machine, put config in `~/work/.gitconfig`
  - if on a personal machine, set up name and email in `~/.identityconfig`
- for Neovim:
  - put local plugin config in `nvim/.config/nvim/lua/plugins/local.lua`

# TODOs

- setup debugging
- Automate creating folder structure for TPM
- Add ~/.config/i3/config
- Add ~/.config/i3blocks/
- Automate creation of `~/.identityconfig` with git name + email
- Pull dependencies from Snap instead of APT
- Refactor custom nvim commands to use Lua instead of Vimscript
- automate install of docker-compose
- Rename ubuntu script
- Set up ranger config
- Automate installation of rust for HTMX LSP
