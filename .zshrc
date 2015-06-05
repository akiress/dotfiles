source ~/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle akiress/zsh plugins/aliases

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Additional completion definitions for zsh
antigen bundle zsh-users/zsh-completions

# Load the theme.
antigen theme xiong-chiamiov-plus

# Tell antigen that you're done.
antigen apply

setopt auto_name_dirs
setopt auto_cd

function list_all() {
	emulate -L zsh
	ls -lahrt
}
chpwd_functions=(${chpwd_function[@]} "list_all")

LS_COLORS='di=1;34:ln=35:so=32:pi=0;33:ex=32:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=1;34:ow=1;34:'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
if whence dircolors >/dev/null; then
    export LS_COLORS
    alias ls='ls --color'
else
    export CLICOLOR=1
fi
