TERM=xterm

export ZSH=$HOME/.zsh

for include in $ZSH/*.zsh; do
    source $include
done

fpath=(/home/akiress/.zsh/completions $fpath)
#plugins=(git gpg-agent perl python vi-mode svn ji=	ra urltools)
#fpath=($ZSH/completions $fpath)

CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

keychain --dir ~/.keychain ~/.ssh/id_dsa ~/.ssh/id_rsa
source ~/.keychain/$HOST-sh
source ~/.keychain/$HOST-sh-gpg

eval $(dircolors ~/.dircolors)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

#Set some keybindings
###############################################
typeset -g -A key
bindkey '^?' backward-delete-char
bindkey '^[[7~' beginning-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[8~' end-of-line
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char 
bindkey '^[[2~' overwrite-mode
#################################################

