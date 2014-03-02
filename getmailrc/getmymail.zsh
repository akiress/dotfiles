#!/bin/zsh

# getmymail.zsh
# ZSH script that uses getmail and calls all emails list in .getmail ending in *.rc.  

GM=$HOME/.getmail

for f in $GM/*.rc; do
    getmail --rcfile $f 
done
