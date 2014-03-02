#! /usr/bin/env python
# -*- coding: utf-8 -*-
#
# updatedotfiles.py
#
# Benjamin Guitreau
#
# Description:
#
# 2013-07-04 12:33
#
# Distributed under terms of the MIT license.
#
# The MIT License (MIT)
#
# Copyright (C) 2013 Benjamin Guitreau
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

"""
Script used to update files that I keep in my dotfiles for git. The files will be stored in a dictionary.
"""

from subprocess import call

HOME = '/home/akiress'
DOT = '/home/akiress/git/dotfiles'

dotfileshome = {'/.vimrc',
                '/.zshrc',
                '/.zprofile',
                '/.Xresources',
                '/.tmux.conf',
                '/.xinitrc',
                '/.config/qtile/config.py',
                '/.weechat/irc.conf',
                '/.weechat/weechat.conf'
                }

dotfiles = {'/etc/portage/package.use/',
            '/etc/portage/package.mask/',
            '/etc/portage/package.unmask/',
            '/etc/portage/package.accept_keywords/',
            '/etc/portage/make.conf',
            '/etc/X11/xorg.conf.d/30-screen.conf',
            '/etc/X11/xorg.conf.d/20-mouse.conf',
            '/etc/X11/xorg.conf.d/10-keyboard.conf',
            '/etc/X11/xorg.conf.d/30-screen-ATI',
            '/usr/src/linux/.config'
            }

for f in dotfileshome:
    filename = HOME + f
    print('Copying ' + filename + ' to ' + DOT + f)
    newDOT = DOT + f
    call(['cp', filename, newDOT])

for f in dotfiles:
    print('Copying ' + f + ' to ' + DOT + f)
    newDOT = DOT + f
    call(['cp', '-r', f, newDOT])

# vim:fenc=utf-8
