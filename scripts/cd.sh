#!/bin/bash

##
# cd
#
# Replaces builtin cd with a wrapper around pushd and popd.
##

pushcd() {
    # Typing just `cd` will take you to $HOME
    if [ "$1" == "" ]; then
        pushd "$HOME" > /dev/null

    # Use `cd -` to visit the previous directory
    elif [ "$1" == "-" ]; then
        pushd $OLDPWD > /dev/null

    # Use `_cd -n` to go n directories back in history
    elif [[ "$1" =~ ^-[0-9]+$ ]]; then
        for i in `seq 1 ${1/-/}`; do
            popd > /dev/null
        done

    # Use `cd -- <path>` if your path begins with a dash
    elif [ "$1" == "--" ]; then
        shift
        pushd -- "$@" > /dev/null

    # Default case: move to a dir and add it to history
    else
        pushd "$@" > /dev/null
    fi
}

alias cd="pushcd"

