#!/bin/sh

VUNDLE=~/.vim/bundle/Vundle.vim

if [ -d "$VUNDLE" ]; then
	echo "Pulling..."
	git -C $VUNDLE pull 
else
	echo "Cloning..."
	git clone https://github.com/VundleVim/Vundle.vim.git $VUNDLE
fi
vim +PluginInstall +qall
