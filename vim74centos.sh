#!/bin/zsh

cd /usr/src/local/src
wget ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
tar -xjf vim-7.4.tar.bz2
cd vim74

./configure --prefix=/usr --with-features=huge --enable-rubyinterp --enable-pythoninterp --enable-python3interp --enable-luainterp --enable-perlinterp
