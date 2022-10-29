#!/usr/bin/env bash

# get PWD
PWD=$(pwd)

# check for config directory
CONFIGDIR="$HOME/linux-config"
[[ -d "$CONFIGDIR" ]] || echo "$CONFIGDIR not found"

function create_link() {

    # check that link destination is existing
    if [[ ! ((-f "$1") || (-d "$1")) ]] ; then
        echo "$1 not found! Skipping..."
        return 1
    fi

    # check that the link location is not existing yet
    if [[ (-f "$2") || (-d "$2") ]]; then
        echo "$2 already exists"
        read -p "Should this file be replaced [y/N]? " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            if [[ -f "$2" ]]; then
                rm "$2"
            else
                rm -rf "$2"
            fi
        else
            return 1
        fi
    fi

    echo "Creating link: $2 -> $1"
    ln -s "$1" "$2"
    return 0
}

# create symbolic links to the configuration files
create_link $CONFIGDIR/bashrc $HOME/.bashrc
create_link $CONFIGDIR/vimrc $HOME/.vimrc
create_link $CONFIGDIR/tmux.conf $HOME/.tmux.conf
create_link $CONFIGDIR/dir_colors $HOME/.dir_colors
create_link $CONFIGDIR/i3 $HOME/.config/i3
create_link $CONFIGDIR/alacritty $HOME/.config/alacritty
create_link $CONFIGDIR/nvim $HOME/.config/nvim

# create alacritty config
cd $CONFIGDIR/alacritty
python3 generate.py

# return to pwd
cd $PWD
