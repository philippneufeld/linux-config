#!/usr/bin/env bash

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

# check for linux-config directory
SCRIPT=$(realpath -s "$0")
CONFIGDIR=$(dirname "$SCRIPT")

# make sure that $HOME/.config directory exists
[[ -d "$HOME/.config" ]] || mkdir "$HOME/.config"

# create symbolic links to the configuration files
create_link "$CONFIGDIR/bashrc" "$HOME/.bashrc"
create_link "$CONFIGDIR/nvim" "$HOME/.config/nvim"

