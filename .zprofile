# /etc/zsh/zprofile
# $Header: /var/cvsroot/gentoo-x86/app-shells/zsh/files/zprofile-1,v 1.1 2010/08/15 12:21:56 tove Exp $

# Load environment settings from profile.env, which is created by
# env-update from the files in /etc/env.d
if [ -e /etc/profile.env ] ; then
	. /etc/profile.env
fi

# VDPAU
export VDPAU_DRIVER=r600

export EDITOR=${EDITOR:-/usr/bin/vim}
export PAGER=${PAGER:-/home/akiress/.vim/bundle/vimpager/vimpager}
export MANPAGER="/home/akiress/.vim/bundle/vimpager/vimpager"

# 077 would be more secure, but 022 is generally quite realistic
umask 022

shopts=$-
setopt nullglob
for sh in /etc/profile.d/*.sh ; do
    [ -r "$sh" ] && . "$sh"
done
unsetopt nullglob
set -$shopts
unset sh shopts
