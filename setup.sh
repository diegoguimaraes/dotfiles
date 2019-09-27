#!/bin/bash
dotfiles="tmux.conf vimrc bashrc"

if [ -d .dotfiles ]; then
    for dotfile in $dotfiles; do
        ln -s ~/.dotfiles/"$dotfile" ~/."$dotfile"
    done
    ln -fs ~/.dotfiles/bashrc ~/.profile
fi

if [ "$1" = "vim" ]; then
    # Setup Vim Plug
    mkdir -p ~/.vim/autoload/
    curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PlugInstall +qall +silent

    #Setup Vim tempdir
    mkdir -p ~/.vimtmp
fi

if [ "$1" = "tmux" ]; then
    mkdir -p ~/.tmux/plugins/
    if [ ! -d ~/.tmux/plugins/resurrect ]; then
        git clone https://github.com/tmux-plugins/tmux-resurrect ~/.tmux/plugins/resurrect
    fi
fi
