#! /usr/bin/env python3
# -*- coding: utf-8 -*-
#
# blockIP_SSH.py
#
# Benjamin Guitreau
#
# Description:
#
# 2013-07-04 15:28
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
To use this file: $ blockIP_SSH.py -i <path-to-file>
This script opens the sshpwauth.txt and retrieves the IP addesses. Then the IP addresses are added to
ipRules.sh. ipRules.sh needs to be run as superuser afterwards to install the new blocks.
"""

import locale

enc = locale.getpreferredencoding()
fname = '/home/akiress/Downloads/sshpwauth.txt'

with open(fname, encoding=enc) as infile:
    inread = infile.read()

print(inread)

infile.close()

# vim:fenc=utf-8
