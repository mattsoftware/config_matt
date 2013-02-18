#!/usr/bin/env bash

# .vim and .vimrc
if [[ ! -d ~/.vim ]]; then
	ln -s `pwd`/vim ~/.vim
fi
if [[ ! -f ~/.vimrc ]]; then
	ln -s `pwd`/vim/vimrc ~/.vimrc
fi

