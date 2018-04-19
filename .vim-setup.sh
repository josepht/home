#!/bin/bash

VUNDLE_DIR=~/.vim/bundle/Vundle.vim

if [ -d $VUNDLE_DIR ];then
	git --git-dir $VUNDLE_DIR/.git pull
else
	git clone https://github.com/VundleVim/Vundle.vim.git $VUNDLE_DIR
fi
vim +PluginInstall +qall
