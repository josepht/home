#!/bin/bash

if [ -L ~/.vim ]; then
    rm -fr ~/.vim
fi

if [ -L ~/.vimrc ]; then
    rm -fr ~/.vimrc
fi

if [ "$1" = "spf13" ]; then
    echo "Setting up spf13 vim..."
	ln -sf ~/.vim-spf13 ~/.vim
	ln -sf ~/.spf13-vim-3/.vimrc ~/.vimrc
else
    echo "Setting up Joe's vim..."
	ln -sf ~/.vim-joe ~/.vim
	ln -sf ~/.vimrc-joe ~/.vimrc
fi

ls -ald ~/.vim*
