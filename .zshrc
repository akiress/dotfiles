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

keychain --dir ~/.keychain ~/.ssh/id_rsa
source ~/.keychain/$HOST-sh

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

# Load environment settings from profile.env, which is created by
# env-update from the files in /etc/env.d
if [ -e /etc/profile.env ] ; then
	. /etc/profile.env
fi

## ============================ ##
##          Functions           ##
## ============================ ##
# rationalize-path()
rationalize-path () {             
  # Note that this works only on arrays, not colon-delimited strings.
  # Not that this is a problem now that there is typeset -T.
  local element
  local build
  build=()
  # Evil quoting to survive an eval and to make sure that
  # this works even with variables containing IFS characters, if I'm
  # crazy enough to setopt shwordsplit.
  eval '
  foreach element in "$'"$1"'[@]"
  do
    if [[ -d "$element" ]]
    then
      build=("$build[@]" "$element")
    fi
  done
  '"$1"'=( "$build[@]" )
  '
}

## ============================ ##
##          Paths               ##
## ============================ ##
# Path for cd to search; used to need to explicitly set "." for the cdmatch
# function (and retained for backward compatibility).
cdpath=( . )
export CDPATH

# Only unique entries please.
typeset -U cdpath

# Path to search for autoloadable functions.
fpath=( $HOME/lib/zsh/func "$fpath[@]" )
export FPATH

# Only unique entries please.
typeset -U fpath

# Include function path in script path so that we can run them even
# though a subshell may not know about functions.
# PATH should already be exported, but in case not. . .
path=(
  "$HOME/bin/$MACHTYPE-$OSTYPE"
  "$HOME/bin/"
  /home/akiress/texlive/bin/x86_64-linux
  /usr/local/bin
  /usr/local/sbin
  /usr/local/etc
  /opt/jdk1.7.0_04/bin
  /opt/cisco/anyconnect/bin/
  /sbin
  /etc
  /bin
  /usr/bin
  /usr/sbin
  /usr/X11/bin
  /usr/bin/X11
  /usr/local/X11/bin
  /usr/local/tex/bin
  /usr/local/lib/zsh/scr
  /usr/local/games
  /usr/games
  "$path[@]"
  "$fpath[@]"
  $JAVA_HOME/bin
  $JAVA_HOME/jre/bin
  $JAVA_HOME/jre
)
export PATH

# Only unique entries please.
typeset -U path

# Remove entries that don't exist on this system.  Just for sanity's
# sake more than anything.
rationalize-path path

# Compilers CSC 4351
export CS4351=~/git/compilers/pub
export PROG=chap5
export TIGER=${CS4351}/tiger
export CLASSPATH=.:..:${CS4351}/classes/${PROG}:${CS4351}/classes
export TEST=${TIGER}/testcases

# XMonad
export PATH=\$PATH:~/.cabal/bin:~/.xmonad/bin
