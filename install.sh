#!/usr/bin/env bash

function log() {
    echo "$1"
}

function logErr() {
    log " *** ERROR: $1 ***"
}

function createLink() {
    SOURCE="$1";shift
    TARGET="$1";shift
    if [[ ! -e "$TARGET" ]]; then
        ln -s "$SOURCE" "$TARGET"
    elif [[ ! -L "$TARGET" ]]; then
        logErr "$TARGET already exists"
    else
        if [[ "$(readlink "$TARGET")" != $SOURCE ]]; then
            logErr "$TARGET exists, but is a symlink already"
        fi
    fi
}

function fileAppend() {
    TARGET="$1";shift
    TEXT="$1";shift
    if [[ -f "$TARGET" ]]; then
        # First check to make sure it is not already in the file!
        grep -Fxq "$TEXT" "$TARGET"
        if [[ $? == 1 ]]; then
            echo "$TEXT" >> "$TARGET"
        fi
    fi
}

# .bash_ext
createLink `pwd`/bashrc_matt ~/.bashrc_matt
createLink `pwd`/bash_profile_matt ~/.bash_profile_matt
fileAppend ~/.bashrc "[[ -f ~/.bashrc_matt ]] && . ~/.bashrc_matt"
fileAppend ~/.bash_profile "[[ -f ~/.bash_profile_matt ]] && . ~/.bash_profile_matt"

# .vim and .vimrc
createLink `pwd`/vim ~/.vim
createLink `pwd`/vim/vimrc ~/.vimrc

# .screenrc
createLink `pwd`/screenrc ~/.screenrc

# initialize the submodules
OIFS="$IFS"
IFS=$'\n'
for x in `git submodule`; do
    if [[ "$x" =~ ^\- ]]; then
        SMPATH=$(echo $x | cut -d' ' -f 2)
        git submodule init $SMPATH
        git submodule update $SMPATH
    fi
done
IFS="$OIFS"

