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

eval `keychain --eval id_rsa`
